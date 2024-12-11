//SPDX-License-Identifier: MIT

//mapping

pragma solidity 0.8.18; 

contract SimpleStorage{

    struct Person{
        uint myFavNum;
        string name;
    }

    //in mapping default value of key is 0
    mapping (string=>uint256) public nameToFavNum;

    
    function addPerson(string memory _name,uint256 _favNum) public {
        nameToFavNum[_name]=_favNum;
    }
    

}
