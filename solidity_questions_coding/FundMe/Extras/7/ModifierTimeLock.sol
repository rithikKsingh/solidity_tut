// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ModifierTimeLock {
    uint256 public time;
    constructor(uint256 _rime) {
        time = _ime;
    }
    modifier onlyAfter(uint256 _time) {
        require(block.timestamp >= _time, "Function not yet available");
        _;
    }
    function withdraw() public onlyAfter(releaseTime) {
        
    }
}

//Source : https://medium.com/coinmonks/solidity-security-practices-part-ii-time-locks-31b9156ee72d
