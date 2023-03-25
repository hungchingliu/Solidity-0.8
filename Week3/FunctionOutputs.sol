// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Return multiple outputs
// Named outputs
// Destructuring arguments

contract FunctionOutputs {
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint u, bool b) {
        return (1, true);
    }

    function assigned() public pure returns (uint u, bool b) {
        u = 1;
        b = true;
    }

    function destructingAssignments() public pure {
        (uint u, bool b) = returnMany();
        (, bool _b) = returnMany();
    }
}