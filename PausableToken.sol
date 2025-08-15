// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PausableToken {
    bool public paused;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals;
    address owner;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balances[msg.sender] = 1000;
        owner = msg.sender;
        paused = false;
    }

    modifier onlyOwner() {
        // 1️⃣ Implement the modifier to allow only the owner to call the function
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }
     function unpause() public onlyOwner {
        paused = false;
    }
  
     // 3️⃣ use the notPaused modifier in this function 
     function mint(address to, uint256 amount) public onlyOwner {
        require(!paused, "Contract is paused");
        totalSupply += amount;
        balances[to] += amount;
    }


    function transfer(address to, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
