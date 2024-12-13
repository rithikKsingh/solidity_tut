// Write a smart contract that uses storage, memory and calldata keywords for its variables.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ExampleContract{
    mapping (address=>uint256) addressToBalance;

     // Function to add balance for an address
    function addBalance(uint256 amount) public {
        require(amount>0,"Amount must be greater than zero");
        addressToBalance[msg.sender]+=amount;
    }

    // Function to retrieve the balance of the sender's address
    function getMyBalance() public view returns(uint256){
        return addressToBalance[msg.sender];
    }

    // Function to retrieve the balance of any address
    function getBalance(address account) public view returns (uint256){
        return addressToBalance[account];
    }
}
