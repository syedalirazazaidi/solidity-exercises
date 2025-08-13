// 0. Make a contract called Calculator ✅
// 1. Create Result variable to store result ✅
// 2. Create functions to add, subtract, and multiply to result ✅
// 3. Create a function to get result ✅


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    // 2️⃣ Result variable to store result (uint256 for non-negative values)
    uint256 public result;

    // 3️⃣ Function to add to result
    function add(uint256 value) public {
        result += value;
    }

    // 3️⃣ Function to subtract from result
    function subtract(uint256 value) public {
        require(result >= value, "Result cannot be negative");
        result -= value;
    }

    // 3️⃣ Function to multiply result by value
    function multiply(uint256 value) public {
        result *= value;
    }

    // 4️⃣ Function to get result
    function getResult() public view returns (uint256) {
        return result;
    }
}