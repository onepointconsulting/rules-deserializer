
const CHILDREN = 'children';

export const buildTree = (origTree: Object) => {
    let copyTree = {...origTree};
    // Build hierarchical structure
    Object.entries(origTree)
        .filter(e => e[1].parent)
        .forEach(nodePair => recurseTreeAndPlaceChild(copyTree, nodePair));
    // Remove children at the top of tree.
    Object.keys(copyTree).filter(k => copyTree[k].parent).forEach(k => delete copyTree[k]);
    console.log(JSON.stringify(copyTree, null, 2));
    // Builds recursively the conditions
    conditionBuilder(copyTree);
    return copyTree;

}

const recurseTreeAndPlaceChild = (tree: Object, nodePair: Array<Object>) => {
    const key = nodePair[0];
    const parent = nodePair[1]['parent'];
    Object.entries(tree).forEach(n => {
        const node = n[1];
        if (parent === n[0]) {
            if (!node[CHILDREN]) {
                node[CHILDREN] = [];
            }
            node[CHILDREN].push({[`${key}`]: {...nodePair[1]}})
        } else if (node[CHILDREN]) {
            node[CHILDREN].forEach(child => recurseTreeAndPlaceChild(child, nodePair));
        }
    })
}

const conditionBuilder =  (copyTree: Object) => Object.entries(copyTree).forEach(n => recurseCondition(n[1], null))

const recurseCondition = function (node, parent) {
    const children = node[CHILDREN];
    if (children) {
        children.forEach(function (c) {
            recurseCondition(Object.entries(c)[0][1], node);
        });
    }
    if (parent) {
        const conditions = node['conditions'];
        const conditionArray : any[] = Object.entries(parent['conditions'])[0][1] as [];
        conditionArray.push(conditions);
        delete parent[CHILDREN];
    }
};