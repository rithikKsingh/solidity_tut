//SPDX-License-Identifier: MIT

pragma solidity 0.8.24; 

//import "./SimpleStorage.sol";
import {SimpleStorage} from "./SimpleStorage.sol";//to import a specific cotract

contract StorageFactory{
    
    SimpleStorage[] public  listOfSimpleStorageContracts;
    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract=new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint _simpleStorageIndex, uint _newSimpleStorageNumber) public{
        //in order to intract with a contract you need two things:
        //1. address
        //2. ABI- Application Binary Interface, (technically a lie, you just need function selector)
        //listOfSimpleStorageContracts automatically compacts with both of them
        SimpleStorage mySimpleStorage=listOfSimpleStorageContracts[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage mySimpleStorage=listOfSimpleStorageContracts[_simpleStorageIndex];
        return mySimpleStorage.retrieve();
    }
}
