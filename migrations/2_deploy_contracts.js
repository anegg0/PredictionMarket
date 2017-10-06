var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var PredictionMarket = artifacts.require("./PredictionMarket.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(PredictionMarket);
};
