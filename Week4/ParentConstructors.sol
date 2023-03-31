// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// 2 ways to call parent constructors
// Order of initialization

contract S {
    string public name;
    event LogS(string message);
    constructor(string memory _name) {
        name = _name;
        emit LogS("S");
    }
}

contract T {
    string public text;
    event LogT(string message);
    constructor(string memory _text) {
        text = _text;
        emit LogT("T");
    }
}

contract U is S("s"), T("t"){

}

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {

    }
}

// The execution order of constuctors is defined by the order of inheritance

// Order of execution
// 1. S
// 2. T
// 3. V0
contract V0 is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {

    }
}

// Order of execution
// 1. S
// 2. T
// 3. V1
contract V1 is S, T {
    constructor(string memory _name, string memory _text) T(_text) S(_name) {

    }
}

// Order of execution
// 1. T
// 2. S
// 3. V2
contract V2 is T, S {
    constructor(string memory _name, string memory _text) T(_text) S(_name) {

    }
}

// Order of execution
// 1. T
// 2. S
// 3. V3
contract V3 is T, S {
    constructor(string memory _name, string memory _text) S(_text) T(_name) {

    }
}