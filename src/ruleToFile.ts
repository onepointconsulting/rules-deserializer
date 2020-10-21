import {createRules} from "./convertRule";
const fs = require('fs');

createRules()
    .then(tree => {
        const targetFile = 'rules.json'
        console.log(`JSON written to ${targetFile}`);
        fs.writeFileSync(targetFile, JSON.stringify(tree, null, 2));
        process.exit(0);
    })
    .catch(e => {
        console.error('Rule creation failed', e);
        process.exit(1);
    });