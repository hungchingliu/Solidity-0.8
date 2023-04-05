// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// visibility
// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside contract
// external - only from outside the contract

/*

| A                 |
| private pri()     |
| internal int()    |
| public pub()      | <------ C
| external ext()    |    pub() and ext()

| B is A            |
| inter()           | <------ C
| pub()             |     pub() and ext()

*/
contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;
    
    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x + y + z;

        privateFunc();
        internalFunc();
        publicFunc();

        // making exteral call to externalFunc(), gas inefficient
        this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function example2 () external view {
        y + z; // not able to call private state var x
        internalFunc();
        publicFunc();
    }
}