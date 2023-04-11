// SPDX-License-Identifier: MIT
pragma solidity >=0.6.9 <0.9.0;

interface IWETH9 {
    function deposit() external payable;
    function withdraw(uint256 _amount) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint);
    
    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract MyERC20 is IWETH9, IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    string public name = "Wrapped Ether";
    string public token = "WETH";
    uint8 public decimals = 18;

    function transfer(address recipient, uint amount) external returns (bool) {
        // Default behaviour of Solidity 0.8 for overflow / underflow is to throw an error
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        // Default behaviour of Solidity 0.8 for overflow / underflow is to throw an error
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
        emit Transfer(address(0x0), msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        require(balanceOf[msg.sender] >= _amount);
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success);
        emit Transfer(msg.sender, address(0x0), _amount);
    }

    receive() external payable {
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
        emit Transfer(address(0x0), msg.sender, msg.value);
    }
}