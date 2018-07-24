pragma solidity ^0.4.17;

import './StandartToken.sol';
import './BurnableToken.sol';

contract LotteryToken is StandartToken, BurnableToken {
    
    string public constant name = "LotteryToken";
    
    string public constant symbol = "LTN";
    
    uint32 public constant decimals = 5;
}