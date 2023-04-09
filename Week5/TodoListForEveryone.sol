// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "./Ownable.sol";

contract TodoList is Ownable {

    // declare a struct for task
    struct Task {
        string name;
        bool completed;
    }

    // declare a addressToTasks mapping
    mapping(address => Task[]) public addressToTasks;

    // create new task and push into the sender's task array
    function create(string calldata _name) external {
        addressToTasks[msg.sender].push(Task(_name, false));
    }   
    
    // update task status by tid
    function update(uint _tid, bool _completed) external {
        addressToTasks[msg.sender][_tid].completed = _completed;
    }

    // get task information by tid
    function get(uint _tid) external view returns(string memory name, bool completed) {
        Task storage task = addressToTasks[msg.sender][_tid];
        name = task.name;
        completed = task.completed;
    }

    // only owner can delete the contract
    function kill() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }

}