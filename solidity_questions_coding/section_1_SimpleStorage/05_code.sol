// Write a smart contract that uses storage, memory and calldata keywords for its variables.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ExampleContract{
    uint256 public num;
    string public name;
    function storageFunc(uint256 newNum) public returns(uint256){
        num=newNum;
        return num;
    }

    function memoryFunc(string memory newName) public  returns(string memory){
        name=newName;
        newName="hi"; // possible in memory
        return name;
    }

    function calldataFunc(string calldata newName) public  returns (string memory){
        name=newName;
        // newName="kkhk"; not possible in calldata
        return name;
    }
}
