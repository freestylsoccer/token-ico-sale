pragma solidity ^0.5.0;

import "./RealEstateToken.sol";

contract TokenSale {
    address payable admin;
    RealEstateToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);
    event Bought(uint256 amount);

    constructor(RealEstateToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    // Guards against integer overflows
    function safeMultiply(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        } else {
            uint256 c = a * b;
            assert(c / a == b);
            return c;
        }
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        //uint256 amountTobuy = msg.value;
        uint256 tokenBalance = tokenContract.balanceOf(address(this));

        //require(amountTobuy > 0, "You need to send some Ether");
        //require(amountTobuy <= tokenBalance, "Not enough tokens in the reserve");
        //tokenContract.transfer(msg.sender, amountTobuy);
        //emit Bought(amountTobuy);

        require(msg.value == safeMultiply(_numberOfTokens, tokenPrice), 'values not match');
        //uint256 scaledAmount = safeMultiply(_numberOfTokens, uint256(10) ** tokenContract.decimals());

        require(tokenBalance >= _numberOfTokens, "Not enough tokens in the reserve");
        tokenContract.transfer(msg.sender, _numberOfTokens);

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));

        // UPDATE: Let's not destroy the contract here
        // Just transfer the balance to the admin
        admin.transfer(address(this).balance);
    }
}