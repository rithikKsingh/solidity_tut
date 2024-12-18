// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Cow} from "./Cow.sol";
import {Birds} from "./Birds.sol";

contract AnimalFactory{
    // function createAnimals() public {
    //     Cow cow=new Cow();
    //     Birds bird=new Birds();

    //     cow.cowSayMow();
    //     bird.birdsChirp();
    // }

    address[] public deployedCows;
    address[] public deployedBirds;

    function createCows(string memory _sound) public {
        Cow cow=new Cow(_sound);
        deployedCows.push(address(cow));
    }

    function createBirds(string memory _sound) public {
        Birds bird=new Birds(_sound);
        deployedBirds.push(address(bird));
    }

    function getAllCows() public view returns (address[] memory){
        return deployedCows;
    }

    function getAllBirds() public view returns (address[] memory){
        return deployedBirds;
    }
}
