// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TinyTipContract{

    uint256 maxTip=10**9;
    function tinyTip() public payable {
        // require(msg.value<maxTip,"Amount should be less than 1 Gwei");
        require(msg.value<1 gwei,"Amount should be less than 1 Gwei");
    }
}
