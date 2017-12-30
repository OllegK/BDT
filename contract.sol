pragma solidity ^0.4.8;
contract HelloWorld {
    uint256 counter = 0;

    function increase() public {
        counter++;
    }

    function decrease() public {
        counter--;
    }

    function getCounter() public view returns(uint256){
        return counter;
    }


    function killme() public {
        selfdestruct(msg.sender);
    }
}