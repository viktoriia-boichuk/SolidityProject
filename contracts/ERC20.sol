pragma solidity ^0.4.17;

/**
 * @title ERC20
 */
contract ERC20 {
    uint256 public totalSupply;
    function balanceOf (address _owner) public view returns (uint256);
    function transfer (address _to, uint256 _value) public returns (bool);
    function approve (address _spender, uint256 _value) public returns (bool);
    function allowance (address _owner, address _spender) public constant returns (uint256);
    function transferFrom (address _from, address _to, uint256 _value) public returns (bool);
    
    event Transfer (address indexed _from, address indexed _to, uint256 _value);
    event Approval (address indexed owner, address indexed spender, uint256 value);
}