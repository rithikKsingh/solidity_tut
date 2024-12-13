// Create a smart contract that can store and view a list of animals. Add manually three (3) 
// animals and give the possibility to the user to manually add an indefinite number of animals into the smart contract.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//using simple array
// contract ExampleContract{
//     string[] public animals;
//     function store(string memory name) public {
//         animals.push(name);
//     }
// }


//using struct
// contract ExampleContract{
//     struct Animal{
//         string name;
//     }
    
//     Animal[] public ani;

//     function store(string memory name) public {
//         ani.push(Animal(name));
//     }
// }

//modified array method
contract ExampleContract{
    string[] public animals;

    constructor(){
        animals.push("lion");
        animals.push("tiger");
        animals.push("dog");
    }
    // Function to add a new animal to the list
    function addAnimal(string memory name) public {
        animals.push(name);
    }

    // Function to retrieve the entire list of animals
    function getAllAnimals() public view returns (string[] memory){
        return animals;
    }

    // Function to retrieve a specific animal by index
    function getAnimal(uint index) public view returns (string memory){
        require(index<animals.length, "Index out of bounds");
        return animals[index];
    }
}
