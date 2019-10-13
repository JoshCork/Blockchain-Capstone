// migrating the appropriate contracts
var Verifier = artifacts.require("./Verifier.sol");
var SolnSquareVerifier = artifacts.require("./SolnSquareVerifier.sol");
const fs = require('fs');

module.exports = function(deployer) {
  deployer.deploy(SolnSquareVerifier);
  // deployer.deploy(Verifier) //FIXME: No longer necessary.
  //         .then(() => {
  //           let config = {
  //             localhost: {
  //               url: 'http://localhost8545',
  //               verifierAddress: Verifier.address
  //             }
  //           }
  //           fs.writeFileSync(__dirname + '/../test/config.json',JSON.stringify(config,null, '\t'),'utf-8');
  //         }
  //         );
};
