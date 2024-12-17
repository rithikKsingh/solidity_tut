// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FundMe{
  function callAmountTo(address adr) public {
        (bool success, ) = payable(adr).call{value: address(this).balance}("");
        require(success, "Ether transfer failed");
    }
}
