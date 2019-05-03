// invoke the compiler by executing "node compile.js" from the ethereum directory

const path = require("path");
const solc = require("solc");
const fs = require("fs-extra");

const buildPath = path.resolve(__dirname, "build");
fs.removeSync(buildPath);

const TSPath = path.resolve(__dirname, "../../../", "register.sol");
const source = fs.readFileSync(TSPath, "utf8");

let jsonContractSource = JSON.stringify({
  language: 'Solidity',
  sources: {
    'Task': {
        content: source,
     },
  },
  settings: { 
      outputSelection: {
          '*': {
              '*': ['abi',"evm.bytecode"],   
           // here point out the output of the compiled result
          },
      },
  },
});

const output = JSON.parse(solc.compile(jsonContractSource))

fs.ensureDirSync(buildPath);

for (let contract in output) {
  fs.outputJsonSync(
    path.resolve(buildPath, contract.replace(":", "") + ".json"),
    output[contract]
  );
}
