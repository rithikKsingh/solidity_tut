// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MathLibrary} from "./MathLibrary.sol";

contract FindSum{
    using MathLibrary for uint256;//// Attach library functions to uint256 type

    function calculateSum(uint256 num1,uint256 num2) public pure returns(uint){
        return num1.sum(num2);
    }
}

// Directly calling the library function
// contract FindSum{
//     using MathLibrary for uint256;//// Attach library functions to uint256 type

//     function calculateSum(uint256 num1,uint256 num2) public pure returns(uint){
//         return MathLibrary.sum(num1, num1);
//     }
// }
