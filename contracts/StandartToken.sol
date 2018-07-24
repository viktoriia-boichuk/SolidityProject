pragma solidity ^0.4.17;

import './ERC20.sol';
import './Limitation.sol';

/**
 * @title Standard ERC20 token
 * @dev Implementation of the ERC-20 standard.
 */
contract StandartToken is ERC20, Limitation {
    
    mapping (address => uint256) balances;
    
    mapping (address => mapping (address => uint256)) allowed;
    
    uint256 public totalSupply;
    
    function balanceOf (address _owner) public view returns (uint256) {
        return balances[_owner];
    }
    
    function transfer (address _to, uint256 _value) canUseTokens public returns (bool) {
        require (_to != address(0) && balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]);
        balances[_to] += _value;
        balances[msg.sender] -= _value;
        emit Transfer (msg.sender, _to, _value);
        return true;
    }
    
    function approve (address _spender, uint256 _value) public returns (bool) {
        require (_spender != address(0) && balances[msg.sender] >= _value && balances[_spender] + _value >= balances[_spender]);
        allowed[msg.sender][_spender] = _value;
        emit Approval (msg.sender, _spender, _value);
        return true;
    }
    
    function allowance (address _owner, address _spender) public constant returns (uint256) {
        return allowed[_owner][_spender];
    }
    
    function transferFrom (address _from, address _to, uint256 _value) canUseTokens public returns (bool) {
        require (allowed[_from][msg.sender] >= _value && balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]);
        balances[_to] += _value;
        balances[_from] -= _value;
        emit Transfer (_from, _to, _value);
        allowed[_from][msg.sender] -= _value;
        return true;
    }
}