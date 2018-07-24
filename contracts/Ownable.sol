pragma solidity ^0.4.17;

/**
 * @title Ownable
 */
contract Ownable {
    address public owner;
    address public temporaryNewOwner;

    constructor () public {
        owner = msg.sender;
    }
    
    modifier onlyOwner () {
        require (msg.sender == owner);
        _;
    }

    function transferOwnership (address newOwner) public onlyOwner {
        require(newOwner != address(0)); 
        temporaryNewOwner = newOwner;
    }
    
    function acceptOwnership () public {
        require (msg.sender == temporaryNewOwner);
        emit TransferOwnership (owner, temporaryNewOwner);
        owner = temporaryNewOwner;
        temporaryNewOwner = 0;
    }
    
    function cancelTransferringOwnership () public onlyOwner {
        temporaryNewOwner = 0;
    }
    
    event TransferOwnership (address indexed from, address indexed to);
}