// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// selfdestruct
// - delete contract
// - force send ether to any address 

// "selfdestruct" has been deprecated. The underlying opcode will eventually undergo breaking changes, and its use is not recommended.
contract Kill {

    constructor() payable {}
    
    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns(uint) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
    function kill(Kill _kill) external {
        _kill.kill();
    }
}