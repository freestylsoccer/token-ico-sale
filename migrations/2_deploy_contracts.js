var RealEstateToken = artifacts.require("RealEstateToken");
var TokenSale = artifacts.require("TokenSale");


module.exports = function(deployer) {
  deployer.deploy(RealEstateToken, 100000000000, "Real Estate Token", "RET", 6).then(function() {    
    // Token price is 0.001 Ether
    var tokenPrice = 1000000000000000;
    return deployer.deploy(TokenSale, RealEstateToken.address, tokenPrice);
  });
};