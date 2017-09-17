var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var SimpleStorage = artifacts.require("./PredictionMarket.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(PredictionMarket);
};
