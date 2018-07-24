pragma solidity ^0.4.17;

import './LotteryToken.sol';
import './MintableToken.sol';

/**
 * @title Crowdsale 
 * @dev Crowdsale contract for ICO.
 */
contract Crowdsale is LotteryToken, MintableToken {
    
    /**
    * Initializes period values.
    */
    constructor () public {
        uint256 initialSupply = 50000000 * 10 ** 5;
        setPeriodValues (0, 1532401200, 1532512800, initialSupply / 100 * 30, 0, 10000 * 10**5);
        setPeriodValues (1, 1532599200, 1532772000, initialSupply - totalSupply - periods[0].tokensPerPeriod, 0, 5000 * 10 ** 5);
        mint (owner, initialSupply / 100 * 20);
    }
    
    /**
    * Calculates the required amount of tokens to be minted. 
    */
    function createTokens() internal {
        uint256 salePeriod = getCurrentPeriod();
        uint256 tokensAmount = periods[salePeriod].rate * msg.value / 1 ether;
        if (tokensAmount > periods[salePeriod].tokensPerPeriod - periods[salePeriod].soldTokens) {
            msg.sender.transfer(msg.value);
        }
        else {
            owner.transfer (msg.value);
            mint (msg.sender, tokensAmount);
        }
    }
    
    /**
    * Called when ETH comes to the contract.
    */
    function() external payable canMint {
        createTokens();
    }
}