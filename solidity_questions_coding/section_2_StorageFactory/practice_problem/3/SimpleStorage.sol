// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
  uint256 num;

  function store(uint256 _num) public {
    num=_num;
  }

  function retrieve() public view returns (uint256){
    return num;
  }

}
