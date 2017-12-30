pragma solidity ^0.4.8;

contract mortal {

    address owner;

    function mortal() public {
        owner = msg.sender;
    }

    modifier onlyowner() {
        if (msg.sender == owner) {    
            _;
        } else {
            revert();
        }
    }

    function kill() public onlyowner {
        selfdestruct(owner);
    }

}