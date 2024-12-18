//Get funds from the users
//withdraw funds
//set a minimum funding value in usd

//NOTE: there is no decimals in solidity , so math is done accordingly

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
error NotOwner();
contract FundMe{
    using PriceConverter for uint256;//The `PriceConverter` functions can then be called 
    //as if they are native to the `uint256` type.

    uint256 public constant MIN_USD=1e18;// we have multiplied 5 with 1e18 because getConversionRate(msg.value) returns the amount in usd*1e18
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        i_owner=msg.sender;
    }

    function fund() public payable {
        //Allow users to send money
        //have a minimum $ sent
        //1. How do we send eth to this contract
        // require(getConversionRate(msg.value)>=MIN_USD,"Didn't send enough eth");//1e18 = 1 ETH= 10**18 Wei = 10^9 Gwei
        require(msg.value.getConversionRate()>=MIN_USD,"Didn't send enough eth");
        //we made our own library. Here msg.value is the first parameter. If getConversion takes more parameters, 
        //do:msg.value.getConversionRate(2nd param,3rd param)
        // msg.value =>is uint256 and is 1e18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=addressToAmountFunded[msg.sender]+msg.value;
    }

    function getVersion() public view returns(uint256) {
        //the address :0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF is for ZKsync network
        //taken from:https://docs.chain.link/data-feeds/price-feeds/addresses?network=zksync&page=1&search=
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        return priceFeed.version();
    }
    //IMPORTANT NOTE
    //When someone pays , where is the amount stored?
    // address(this).balance:
    // What it is: The balance of the contract.
    // Where it's stored: This is part of Ethereum's account storage system and reflects the total amount of Ether held by the contract at any given moment.
    // How it is updated: Every time a user sends Ether to the contract via the fund() function, the contract's balance increases automatically.
    // Accessing it: You can retrieve the current balance of the contract using address(this).balance.

    // Where Is the Ether Actually Stored?
    // The Ether itself is stored in the Ethereum account system associated with the contract's address. Smart contracts do not directly hold Ether as a variable; 
    // instead, the Ethereum blockchain maintains an account for the contract where the Ether is stored.

    function withdraw() public onlyOwner{

        for(uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        funders = new address[](0);
        //The simplest way to reset the `funders` array is similar to the method used with 
        //the mapping: iterate through all its elements and reset each one to 0. Alternatively,
        // we can create a brand new `funders` array.

        //Sending ETH from a contract

        //1. USING TRANSFER
        //this -> refers to current contract
        //msg.sender -> address
        //payable(msg.sender) -> payable address
        // payable(msg.sender).transfer(address(this).balance);

        //2. Using Send
        // bool sendSuccess=payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send failed");

        //3. Using Call
        // (bool success, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call failed");

    }

    function callAmountTo(address adr) public {
        (bool success, ) = payable(adr).call{value: address(this).balance}("");
        require(success, "Ether transfer failed");
    }

    modifier onlyOwner(){
        // require(msg.sender==i_owner,"Must be owner");
        if(msg.sender!=i_owner) {revert NotOwner(); } // saves gas as u are not storing any string like: "Must be owner"
        _;
    }


    //When a user sends Ether **directly** to the `fundMe` contract without calling the `fund` function, 
    // the `receive` function can be used to _redirect_ the transaction to the `fund` function

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
    }
    //This approach ensures that all transactions are processed as intended. Although directly calling the `fund` 
    //function costs less gas, this method ensures the user's contribution is properly acknowledged and credited

}

//if less than 1 ETH is sent, it is a failed transaction and the value of "myVal" 
// remains unchanged. 
//Note: for failed transaction, gas is used and it cannot be recovered. as miners need to be compensated.
//However you can specify the amound of gas to be used. 
