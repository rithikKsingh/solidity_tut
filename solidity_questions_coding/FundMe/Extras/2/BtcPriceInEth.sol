// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//Address of BTC / ETH(from chainlink):0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22
//network: sepolia
contract BtcPriceInEth{
    function getLatestBTCPriceInETH() public view returns (uint256){
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
        (, int256 price, , , )=priceFeed.latestRoundData();  
        return uint256(price*1e10);      
    }
}
