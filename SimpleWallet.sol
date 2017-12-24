pragma solidity ^0.4.8;

import "github.com/OllegK/BDT/mortal.sol";

contract SimpleWallet is mortal {
    
    mapping (address => Permission) myAddressMapping;
    
    event contractDeployed(address owner);
    event someoneAddedSomeoneToTheSendersList(address thePersonWhoAdded, address thePersonWhoIsAllowedNow, uint thisMuchHeCanSend);
    event someoneDeletedSomeoneFromTheSendersList(address thePersonWhoRemoved, address thePersonWhoIsRemoved);
    event someoneTransferedToSomeone(address thePersonWhoTransfered, address thePersonWhoReceived, uint amount);
    event somebodyFunded(address thePersonWhoFunded, uint value);
    
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    function SimpleWallet() public {
        //Automatically add the creator of the wallet to the permitted senders list. Makes things easier.
        myAddressMapping[msg.sender] = Permission(true, 5000 ether);
        contractDeployed(msg.sender);
    }    
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
        someoneAddedSomeoneToTheSendersList(msg.sender, permitted, maxTransferAmount);
    }
    
    function removeAddressFromSendersList(address removed) public onlyowner {
        delete myAddressMapping[removed];
        someoneDeletedSomeoneFromTheSendersList(msg.sender, removed);
    }
    
    function sendFunds(address receiver, uint amountInWei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferAmount >= amountInWei);
        receiver.transfer(amountInWei);
        someoneTransferedToSomeone(msg.sender, receiver, amountInWei);    
    }

    function () public payable {
        somebodyFunded (msg.sender, msg.value);
    } 
}