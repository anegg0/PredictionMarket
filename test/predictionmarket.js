var PredictionMarket = artifacts.require("./PredictionMarket.sol");

contract('PredictionMarket', function(accounts) {
  var instance;
  PredictionMarket.deployed()
  it("...should add a new market.", function() {
    return PredictionMarket.deployed()
    .then(_instance => {
      PredictionMarketInstance = _instance;
      return PredictionMarketInstance.insertMarket.call("will it be OK?", 5,{from: accounts[0]});
    })
    .then(storedNewMarket => {
      return PredictionMarketInstance.getMarkets.call(1);
    }).then(response => {
      assert.equal(response.toString(), "will it be OK?", "The market doesn't return will it be OK?");
    });
  });

});
