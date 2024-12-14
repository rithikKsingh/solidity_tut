
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Birds{
    // event Log(string);

    // constructor(){
    //     emit Log("Birds contract deployed");
    // }

    // function birdsChirp() public {
    //     emit Log("Birds chirp");
    // }

    string public sound;
    constructor(string memory _sound){
        sound=_sound;
    }        
}
