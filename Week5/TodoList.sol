// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract TodoList {

    // declare a struct for task
    struct Task {
        string name;
        bool completed;
    }

    // declare a dynamic array of tasks to store tasks 
    Task[] public tasks;

    // pass in task name by calldata and push the new task into task array
    // completed is initialize to false
    function create(string calldata _name) external {
        // use memory in input string params: 69829 gas
        // use calldata in input string params: 69550 gas
        tasks.push(Task(_name, false));
    }   
    
    // update task status by tid
    function update(uint _tid, bool _completed) external payable {
        // non payable 46281 gas
        // payable 46257 gas
        tasks[_tid].completed = _completed;
    }

    // get task information by tid
    function get(uint _tid) external view returns(string memory name, bool completed) {
        // name = tasks[_tid].name;
        // completed = tasks[_tid].completed;
        // 8387 gas

        // Task memory task = tasks[_tid];
        // name = task.name;
        // completed = task.completed;
        // 8300 gas

        Task storage task = tasks[_tid];
        name = task.name;
        completed = task.completed;
        // 8209 gas
    }

    // delete the contract
    function kill() external {
        selfdestruct(payable(msg.sender));
    }

}