import {dbConfig} from "./dbConfig_2";
import {buildTree} from "./treeBuilder";

const sql = require('mssql');
const poolPromise = new sql.ConnectionPool(dbConfig).connect();

const ruleElementMap = {'AND': 'all', 'OR': 'any'};

const operatorMap = {
    '>': 'greaterThan',
    '<': 'lessThan',
    '>=': 'greaterThanEquals'
}

const buildCondition = (field, ruleOperator, value) => {
    return {
        fact: field,
        operator: operatorMap[ruleOperator],
        value: value
    }
}

export const createRules = () => {
    return new Promise((resolve, reject) => {
        poolPromise
            .then(conn => {
                const request = conn.request();
                return request.query(`select rd.ID, rd.NAME as rule_name, rd.EVENT_TYPE, rd.EVENT_DATA, rd.OPERATOR rule_operator, 
                                rc.FIELD, rc.OPERATOR  condition_operator, rc.VALUE, rd.parent from rule_definition rd 
                                left join [dbo].[rule_condition] rc on rd.ID = rc.RULE_ID
                                order by 1`);
            })
            .then(res => {
                const ruleJson = res.recordset.reduce((ac, r) => {
                    const ruleId = r.ID;
                    const ruleOperator = ruleElementMap[r.rule_operator];
                    if (!ac[ruleId]) { // If the rule does not exist yet
                        ac[ruleId] = {
                            rule_name: r.rule_name,
                            conditions: {
                                [ruleOperator]: r.FIELD ? [buildCondition(r.FIELD, r.condition_operator, r.VALUE)] : []
                            },
                            event: {
                                type: r.EVENT_TYPE,
                                params: {
                                    message: r.EVENT_DATA
                                }
                            }
                        };
                        if (r.parent) {
                            ac[ruleId].parent = `${r.parent}`;
                        }
                    } else {
                        ac[ruleId]['conditions'][ruleOperator].push(buildCondition(r.FIELD, r.condition_operator, r.VALUE));
                    }
                    return ac;
                }, {});
                resolve(buildTree(ruleJson));
            })
            .catch((e) => {
                reject(e);
            });
    })

}