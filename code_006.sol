//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

//inheritance
contract AddFiveStorage is SimpleStorage{
    function sayHello() public pure returns(string memory){
        return "Hello";
    }

    //overriding -> 1. overrides 2.virtual override
    // in child class , use-> "override" keyword. 
    // dont forget to use "virtual" keyword in parent class
    function store(uint256 _newNum) public override {
        favNum=_newNum+5;
    }
}
