// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint256) {
        //1.address :0x694AA1769357215DE4FAC081bf1f309aDC325306-> to get address, 
        // go to price feed section in chain link and then find sepolia testnet . there copy the address
        // of eth/usd pair
        //2. ABI: its just the list of functions.-> import aggregator interface. 
        // you can find it on : https://docs.chain.link/data-feeds/using-data-feeds
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (, int256 price, , , )=priceFeed.latestRoundData();
        // (uint80 roundId, int256 price, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)=priceFeed.latestRoundData();

        //price of eth is in terms of usd. price is returned without deciamls with 8 extra zeros
        return  uint256(price*1e10);
        //When multiplying the latest ETH price by 1e10,  the intent is to standardize the scale of the 
        //price for calculations that require 18-decimal precision, commonly used in Ethereum-based smart contracts.
        //The Chainlink price feed for ETH/USD in this example returns the price with 8 decimal places of precision. 
        //For instance, if the ETH price is $1234.56789012, it is represented as:
        //answer = 123456789012 (8 decimals)
        //In Ethereum, most token contracts (e.g., ERC20 tokens) and calculations involving token balances 
        //or values use 18 decimals of precision. For example, 1 ETH is internally represented as:1eth=1 * 10^18 Wei

    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice=getPrice();
        uint256 ethAmountInUsd=(ethPrice*ethAmount)/1e18;
        // > The line `uint256 ethAmountInUsd = (ethPrice * ethAmount)` results in a value with a precision 
        // of 1e18 * 1e18 = 1e36. To bring the precision of `ethAmountInUsd` back to 1e18, we need to divide the result by 1e18.

        // Always multiply before dividing to maintain precision and avoid truncation errors. 
        // For instance, in floating-point arithmetic, `(5/3) * 2` equals approximately 3.33. 
        // In Solidity, `(5/3)` equals 1, which when multiplied by 2 yields 2. If you multiply first 
        // `(5*2)` and then divide by 3, you achieve better precision.

        return ethAmountInUsd;
    }    
}
