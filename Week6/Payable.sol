// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Payable {
    // payable modifier must come right after address, allows address to receive eth
    address payable public owner;
    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    function sendFromEtherToOwner(uint _value) external returns(bool) {
        (bool sent, ) = owner.call{value: _value}("");
        return sent;
    }

}