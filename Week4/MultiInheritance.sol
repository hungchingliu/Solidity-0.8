// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// Order of inheritance - most base-like to derived

/* 
     X
   / |
  Y  |
   \ |
     Z

// order of most base like to derived
// X, Y, Z

     X
   /   \
  Y     A
  |     |
  |     B
   \   /
     Z


// order of most base like to derived
// X, Y, A, B, Z
*/

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {    // order of multiple inheritance matters
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }

    function bar() public pure override(Y, X) returns (string memory) {
        return "Z";
    }
}