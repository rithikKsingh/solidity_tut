// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Cow{
    // event Log(string message);
    // constructor(){
    //     emit Log("Cows contract created");
    // }

    // function cowSayMow() public {
    //     emit Log("cow says mow");
    // }

    string public sound;
    constructor(string memory _sound){
        sound=_sound;
    }
}
