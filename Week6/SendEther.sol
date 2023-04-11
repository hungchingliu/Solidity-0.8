// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// 3 ways to send ether
// transfer, 2300 gas, revert
// send, 2300 gas, returns bool
// call, all gas, returns bool and data

contract SendEther {
    constructor() payable {}

    receive() external payable {}

    // gasleft: 2260
    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    // gasleft: 2260
    function sendViaSend(address payable _to) external payable {
        bool sent = _to.send(123);
        // require(sent, "send failed");
    }

    // gasleft: 6521
    function sendViaCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}("");
        // require(success, "call failed");
    }

}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}

// Comment out require to test send ether fail, only sendViaTransfer will revert
contract CannotReceiveEth {

}