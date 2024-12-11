//SPDX-License-Identifier: MIT

pragma solidity 0.8.18; // tells the compiler which solidity version to use
// ^0.8.18 tells the compiler to use version greater than or equal to 0.8.18. 
//pragma solidity >=0.8.18 < 0.9.0; version greater than equal to 0.8.18 and less than 0.9.0

contract SimpleStorage{
    //basic types: boolean,uint,int,string,address,bytes

    bool hasFavNum=true;
    uint256 favUnsignedInt=88; //by default uint = uint256
    string favNumText="fav-num";
    int256 favInt256=-88;
    address myAdd=0x2A415a53733e7D7a1C82118980E9EE53e1279BFf;
    bytes32 favBytes32="cat"; //bytes is not equal to bytes32. Its similar to string as string is converted to bytes object

    //they also have default values. unit->0 , bool->false
    uint256 public favNum;

    function store(uint256 _favNum) public {
        favNum=_favNum;
    }
    //more statements inside this store function, the more gas is required.

    //view/pure functions cannot alter the state of a variable.Therefore does not require gas
    // however if they called from a function which can alter the state of a variable, then you need to
    //pay execution cost
    function retrieve() public view returns(uint256){
        return favNum;
    }


}
