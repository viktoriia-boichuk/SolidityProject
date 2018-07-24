pragma solidity ^0.4.17;

import './StandartToken.sol';

contract MintableToken is StandartToken {
    
    bool public mintingStopped = false;
    
    modifier canMint() {
        require(!mintingStopped);
        
        _;
    }
    
    function mint (address _to, uint256 _value) canMint internal returns (bool) {
        totalSupply += _value;
        balances[_to] += _value;
        emit Mint(_to, _value);
        return true;
    }

    function finishMinting() public onlyOwner returns (bool) {
        mintingStopped = !mintingStopped;
        emit MintStopped();
        return true;
    }
    
    event Mint(address indexed _to, uint256 _value);
    
    event MintStopped ();
}