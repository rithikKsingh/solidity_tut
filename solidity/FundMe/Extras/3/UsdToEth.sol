// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract UsdToEth {
    function usdToEthPrice(uint256 usdAmount) public view returns (uint256) {
        // Fetch ETH price in USD from Chainlink Price Feed
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        
        // Ensure the price is positive
        require(price > 0, "Invalid price data");

        // Convert to uint256 and adjust decimals to 18
        uint256 ethPrice = uint256(price) * 1e10;

        // Return the converted value
        return convertUsdToEth(usdAmount * 1e18, ethPrice); // Scale USD amount to 18 decimals
    }

    function convertUsdToEth(uint256 usdAmount, uint256 ethPrice) internal pure returns (uint256) {
        require(ethPrice > 0, "ETH price must be greater than zero");
        return usdAmount / ethPrice;
    }
}
