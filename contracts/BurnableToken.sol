pragma solidity ^0.4.17;

import './StandartToken.sol';

contract BurnableToken is StandartToken {
    
    function burn (uint256 _value) canUseTokens public returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(msg.sender, _value);
        return true;
    }
 
    function burnFrom(address _from, uint _value) canUseTokens public returns (bool success) {
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
        balances[_from] -= _value;
        totalSupply -= _value;
        allowed[_from][msg.sender] -= _value;
        emit Burn(_from, _value);
        return true;
    }

    event Burn(address indexed _burner, uint indexed _value);
}
