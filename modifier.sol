// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PausableToken {
    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;          // The deployer becomes the owner
        paused = false;              // Start as not paused
        balances[owner] = 1000;      // Give the owner 1000 tokens
    }

    // 1️⃣ Modifier: Only allow the owner to call
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner!");
        _; // Continue with the rest of the function
    }

    // 2️⃣ Modifier: Only allow if contract is not paused
    modifier notPaused() {
        require(!paused, "Contract is paused!");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    // 3️⃣ Use notPaused so transfers only work when contract is active
    function transfer(address to, uint amount) public notPaused {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
