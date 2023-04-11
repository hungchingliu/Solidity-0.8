// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract FunctionSelector {
    function getSelector(string calldata _func) pure external returns(bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

contract Receiver {
    event Log(bytes data);

    // "transfer(address,uint256)" => 0xa9059cbb
    // function signature should use full type name uint256
    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
        //0xa9059cbb
        //000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb2
        //000000000000000000000000000000000000000000000000000000000000000a value = 10
    }
}