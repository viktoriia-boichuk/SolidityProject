pragma solidity ^0.4.17;

import './Ownable.sol';

contract Limitation is Ownable{
    
    /**
    * Data type to save information about periods.
    */
    struct Period {
        //Period number
        uint256 number;
        // UNIX timestamp of period start
        uint256 start;
        // UNIX timestamp of period finish
        uint256 end;
        //Amount of tokens available per period
        uint256 tokensPerPeriod;
        //Sold tokens amount
        uint256 soldTokens;
        // Price per token per period
        uint256 rate;
    }
    
    Period[] public periods;
    
    /**
    * Function to set period values.
    */
    function setPeriodValues (uint256 number, uint256 start, uint256 end, uint256 tokensPerPeriod, uint256 soldTokens, uint256 rate) internal {
        if (number != 0) {
            require (start >= periods[number-1].end);
        }
        require (end >= start);
        periods.push(Period(number, start, end, tokensPerPeriod, soldTokens, rate));
    }
    
    /**
    * Function to change period values.
    */
    function changePeriodValues (uint256 number, uint256 start, uint256 end, uint256 rate) public onlyOwner {
        require (periods.length - 1 >= number);
        setPeriodValues(number, start, end, periods[number].tokensPerPeriod, periods[number].soldTokens, rate);
    }
    
    /**
    * Function to get period values.
    */
    function getCurrentPeriod() public constant returns (uint256) {
      for (uint i = 0; i < periods.length; i++) {
        if (periods[i].start <= now && periods[i].end >= now) {
          return periods[i].number;
        }
      }
    }
    
    /**
    * Throws if called during crowdsale.
    */
    modifier canUseTokens () {
        require (now > periods[periods.length - 1].end);
        _;
    }
}