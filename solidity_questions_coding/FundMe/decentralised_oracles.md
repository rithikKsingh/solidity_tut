  ### Introduction

  With blockchain technology and decentralized finance (DeFi) on the rise, supporting multiple currencies is increasingly important. 
  It broadens accessibility and usability for users. This lesson focuses on adding a currency conversion feature to the fundMe 
  contract using Chainlink Oracle, a decentralized data network.

  ### The Problem

  Currently, the fundMe contract requires at least 1 ETH for transactions. If we want users to transact with a minimum of $5, 
  we need a way to convert between USD and ETH. However, Ethereum doesn’t inherently support USD conversion because it only 
  understands on-chain data (like ETH). This creates the Oracle problem—blockchains lack access to off-chain data like real-world currency prices.

  Solution: Chainlink

  Chainlink, a decentralized Oracle network, bridges this gap. It securely connects smart contracts with off-chain data, 
  ensuring reliable data transmission without central points of failure. 
  
  Here's how its features help:
  1. Data Feeds: Aggregate cryptocurrency price data from exchanges and deliver accurate pricing to smart contracts (like ETH/USD conversion).
  2. VRF (Randomness): Provides provable randomness for fair lotteries, gaming, and NFTs.
  3. Automation (Keepers): Automatically triggers smart contract actions based on predefined conditions.
  4. Functions: Allows smart contracts to make API calls to fetch external data for advanced use cases.

  Chainlink in FundMe:
  Using Chainlink Data Feeds, the fundMe contract can fetch live ETH/USD prices to enable currency conversion. 
  This ensures users can fund the contract with $5 worth of ETH, improving flexibility and usability.


  Conclusion
  Chainlink solves the Oracle problem while offering additional tools like randomness, automation, and API integration to 
  create feature-rich decentralized applications. It’s a powerful choice for enhancing blockchain projects.
