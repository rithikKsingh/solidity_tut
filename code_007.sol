//Get funds from the users
//withdraw funds
//set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract FundMe{
    uint256 public myValue=1;
    function fund() public payable {
        //Allow users to send money
        //have a minimum $ sent
        //1. How do we send eth to this contract
        myValue=myValue+2;
        require(msg.value>1e18,"Didn't send enough eth");//1e18 = 1 ETH= 10**18 Wei = 10^9 Gwei
    }
    // function withdraw() public {}
}

//if less than 1 ETH is sent, it is a failed transaction and the value of "myVal" 
// remains unchanged. 
//Note: for failed transaction, gas is used and it cannot be recovered. as miners need to be compensated.
//However you can specify the amound of gas to be used. 

//When a revert is triggered in a smart contract, the following occurs:
//Undo All Operations: Any changes made to the blockchain during the execution of the transaction 
//(like updating balances or modifying storage) are rolled back to their original state, as though the transaction never happened.
//Return Remaining Gas: The portion of gas that was allocated for the transaction but not used up is returned to the sender 
//(the account initiating the transaction). However, any gas already consumed for the operations leading up to the revert is not refunded because the work was still performed by the network's nodes.
//For example:

//If a transaction is allotted 50,000 gas, but only 30,000 gas is consumed before a revert, the remaining 20,000 gas is returned to the sender.
//However, the sender still loses the cost of the 30,000 gas consumed.
//This ensures fairness because computational resources used up to the point of failure are compensated, but the system prevents further wastage of resources by halting execution.
