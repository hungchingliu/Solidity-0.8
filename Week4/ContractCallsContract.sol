// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Callee {
    event Log(address indexed msgSender, address indexed txOrigin);
    function f() external {
        emit Log(msg.sender, tx.origin);
    }
}

contract Caller {
    Callee public callee;

    constructor(address _address){
        callee = Callee(_address);
    }

    function call() external {
        callee.f();
    }
}