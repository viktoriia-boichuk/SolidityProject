pragma solidity ^0.4.17;

import './StandartToken.sol';

/**
 * @title Mintable token
 * @dev Mints new tokens.
 */
contract MintableToken is StandartToken {
    
    bool public mintingStopped = false;
    
    /**
    * Throws if called when minting is stopped or paused.
    */
    modifier canMint() {
        require(!mintingStopped);
        require(periods[0].start <= now && periods[0].end >= now || periods[1].start <= now && periods[1].end >= now);
        _;
    }
    
    function mint (address _to, uint256 _value) canMint internal returns (bool) {
        totalSupply += _value;
        balances[_to] += _value;
        emit Mint(_to, _value);
        return true;
    }

    /**
    * Stop minting if needed.
    */
    function stopMinting() public onlyOwner returns (bool) {
        mintingStopped = !mintingStopped;
        emit MintStopped();
        return true;
    }
    
    event Mint(address indexed _to, uint256 _value);
    
    event MintStopped ();
}