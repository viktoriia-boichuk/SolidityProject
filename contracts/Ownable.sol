pragma solidity ^0.4.17;

/**
 * @title Ownable
 * @dev Provides basic authorization control functions.
 */
contract Ownable {
    address public owner;
    address public temporaryNewOwner;

    constructor () public {
        owner = msg.sender;
    }

    /**
    * Throws if called by any account other than the owner.
    */
    modifier onlyOwner () {
        require (msg.sender == owner);
        _;
    }

    /**
    * Appoints new contract owner.
    */
    function transferOwnership (address newOwner) public onlyOwner {
        require(newOwner != address(0)); 
        temporaryNewOwner = newOwner;
    }
    
    /**
    * Function to make sure new owner is at right address.
    */
    function acceptOwnership () public {
        require (msg.sender == temporaryNewOwner);
        emit TransferOwnership (owner, temporaryNewOwner);
        owner = temporaryNewOwner;
        temporaryNewOwner = 0;
    }
    
    /**
    * Function to cancel transferring ownership if smth goes wrong.
    */
    function cancelTransferringOwnership () public onlyOwner {
        temporaryNewOwner = 0;
    }
    
    event TransferOwnership (address indexed from, address indexed to);
}