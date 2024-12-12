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
