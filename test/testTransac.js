var RealEstateToken = artifacts.require("./RealEstateToken.sol");
contract('RealEstateToken', function(accounts) {
	var tokenInstance;

	it('get the correct values from the contract', function() {
		return RealEstateToken.deployed().then(function(instance) {
		  tokenInstance = instance;
		  // Test `require` statement first by transferring something larger than the sender's balance
		  return tokenInstance.name();
		}).then(function(name){
            assert.equal(name, 'Real Estate Token', 'has the correct name');
            return tokenInstance.symbol();
		}).then(function(sym){
            assert.equal(sym, 'RET', 'has the correct symbol');
        });
	  });
});