// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "./Ownable.sol";

// add onlyOwner function modifier to every external function

contract TodoList is Ownable {

    // declare a struct for task
    struct Task {
        string name;
        bool completed;
    }

    // declare a dynamic array of tasks to store tasks 
    Task[] public tasks;

    // pass in task name by calldata and push the new task into task array
    // completed is initialize to false
    function create(string calldata _name) external onlyOwner {
        tasks.push(Task(_name, false));
    }   
    
    // update task status by tid
    function update(uint _tid, bool _completed) external onlyOwner {
        tasks[_tid].completed = _completed;
    }

    // get task information by tid
    function get(uint _tid) external view onlyOwner returns(string memory name, bool completed) {
        name = tasks[_tid].name;
        completed = tasks[_tid].completed;
    }

    // delete the contract
    function kill() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }

}