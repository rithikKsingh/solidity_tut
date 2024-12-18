// Write a contract that features 3 functions:
//   * a view function that can be accessed only by the current contract
//   * a pure function that's not accessible within the current contract
//   * a view function that can be accessed from children's contracts


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MyContract{
    uint256 public num=88;
    
    // A private view function, accessible only within this contract
    function firstFunc() private view returns (uint256){
        return num+2;
    }

    // A pure function, not accessible within the current contract
    function secFunc() external pure returns (uint256){
        return 1;
    }

    // An internal view function, accessible by derived contracts
    function thirdFunc() internal view returns (uint256){
        return num+12; 
    }

    // Example function to demonstrate private function usage
    function callPrivateMem() external  view returns (uint256){
        return firstFunc();
    }

}

contract ChildContract is MyContract{
    // Function to demonstrate access to the internal function
    function callInternalFunc() external view returns(uint256){
        return thirdFunc();
    }
}
