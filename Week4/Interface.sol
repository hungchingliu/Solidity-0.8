// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ICounter {
    function count() external view returns (uint); // solidity creates getter function for public state variable
    function inc() external;
}

contract CallInterface {
    uint public count;

    function example(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}