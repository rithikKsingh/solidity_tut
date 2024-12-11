//SPDX-License-Identifier: MIT

pragma solidity 0.8.18; 

contract SimpleStorage{

    struct Person{
        uint myFavNum;
        string name;
    }

    Person public pat= Person(7,"rithik");

    Person[] public listOfPerson;//dynamic array
    // Person[3] public arr; -> static array

    function addPerson(string memory _name,uint256 _favNum) public {
        // Person memory newPerson=Person(_favNum,_name);
        // listOfPerson.push(newPerson);

        listOfPerson.push(Person(_favNum,_name));
    }
    

}
