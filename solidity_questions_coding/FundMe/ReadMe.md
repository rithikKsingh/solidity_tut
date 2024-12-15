### Overview

For this project, we will be using two contracts: `FundMe`, the main crowdfunding contract, and `PriceConverter`. 
They function much like Kickstarter, allowing users to send any native blockchain cryptocurrency. 
They also enable the owner of the contract to **withdraw** all the funds collected. We will then deploy these contracts on a testnet.

### fund and withdraw

Once `FundMe` is deployed on Remix, you'll notice a set of _functions_, including a new red 
button labelled `fund`, indicating that the function is _payable_. A payable function allows 
you to send native blockchain currency (e.g., Ethereum, Polygon, Avalanche) to the contract.

We'll additionally indicate a minimum USD amount to send to the contract when the function 
`fund` is called. To transfer funds to the `FundMe` contract, you can navigate to the value 
section of the Remix deployment tab, enter a value (e.g. 0.1 ether) then hit `fund`. A MetaMask 
transaction confirmation will appear, and the contract balance will remain zero until the transaction 
is finalized. Once completed, the contract balance will be updated to reflect the transferred amount.

The contract owner can then `withdraw` the funds. In this case, since we own the contract, the balance will be 
removed from the contract's balance and transferred to our wallet.

### value and payable

When a transaction it's sent to the blockchain, a **value** field is always included in the _transaction data_. 
This field indicates the **amount** of the native cryptocurrency being transferred in that particular transaction.
For the function `fund` to be able to receive Ethereum, it must be declared **`payable`**. 
In the Remix UI, this keyword will turn the function red, signifying that it can accept cryptocurrency.

_Wallet addresses_ and _smart contracts_ are capable of **holding** and **managing** cryptocurrency funds. 
These entities can interact with the funds, perform transactions, and maintain balance records, just like a wallet.

```
function fund() public payable {
    // allow users to send $
    // have a minimum of $ sent
    // How do we send ETH to this contract?
    msg.value;

    //function withdraw() public {}
}
```

In Solidity, the **value** of a transaction is accessible through the [`msg.value`](https://docs.soliditylang.org/en/develop/units-and-global-variables.html#special-variables-and-functions) **property**. This property is part of the _global object_ `msg`. 
It represents the amount of **Wei** transferred in the current transaction, where _Wei_ is the smallest unit of Ether (ETH).

### Reverting transactions

We can use the`require` keyword as a checker, to enforce our function to receive a minimum `value` of one (1) whole ether:

```
require(msg.value > 1e18); // 1e18 = 1 ETH = 1 * 10 ** 18
```
This `require` condition ensures that the transaction meets the minimum ether requirements, allowing the function to execute 
only if this threshold is satisfied. If the specified requirement is not met, the transaction will **revert**.

The require statement in Solidity can include a custom error message, which is displayed if the condition isn't met, 
clearly explaining the cause of the transaction failure:

```
require(msg.value > 1 ether, "Didn't send enough ETH"); //if the condition is false, revert with the error message
```

> 👀❗**IMPORTANT**:br
> 1 Ether = 1e9 Gwei = 1e18 Wei

> 🗒️ **NOTE**:br
> Gas costs are usually expressed in Gwei

If a user attempts to send less Ether than the required amount, the transaction will **fail** and a _message_ will be displayed. For example, if a user attempts to send 1000 Wei, which is significantly less than one Ether, the function will revert and does not proceed.

**Reverts** and **gas usage** help maintain the integrity of the blockchain state. _Reverts_ will undo transactions when failures occur, while _gas_ enables transactions execution and runs the EVM. When a transaction fails, the gas consumed is not recoverable. To manage this, Ethereum allows users to set the maximum amount of gas they're willing to pay for each transaction.

### Transaction Fields

During a **value** transfer, a transaction will contain the following fields:

* **Nonce**: transaction counter for the account
* **Gas price (wei)**: maximum price that the sender is willing to pay _per unit of gas_
* **Gas Limit**: maximum amount of gas the sender is willing to use for the transaction. A common value could be around 21000.
* **To**: _recipient's address_
* **Value (Wei)**: amount of cryptocurrency to be transferred to the recipient
* **Data**: 🫙 _empty_
* **v,r,s**: components of the transaction signature. They prove that the transaction is authorised by the sender.

During a _**contract interaction transaction**_, it will instead be populated with:

* **Nonce**: transaction counter for the account
* **Gas price (wei)**: maximum price that the sender is willing to pay _per unit of gas_
* **Gas Limit**: maximum amount of gas the sender is willing to use for the transaction. A common value could be around 21000.
* **To**: _address the transaction is sent to (e.g. smart contract)_
* **Value (Wei)**: amount of cryptocurrency to be transferred to the recipient
* **Data**: 📦 _the content to send to the_ _**To**_ _address_, e.g. a function and its parameters.
* **v,r,s**: components of the transaction signature. They prove that the transaction is authorised by the sender.


### Questions
Bob sets his gas price to 20 Gwei and his gas limit to 50,000 units. 
The transaction consumes 30,000 units of gas before a revert occurs. How much ETH will be effectively charged?

Solution : 1 Eth = 10^9 Gwei
1 Gwei=1*10^-9 ETH
20*30000 Gwei= 600000 * 10^-9 = 0.0006 ETH

-------
### Decentralised oracles
### Introduction
With blockchain technology and decentralized finance (DeFi) on the rise, supporting multiple currencies is increasingly important. It broadens accessibility and usability for users. This lesson focuses on adding a currency conversion feature to the fundMe contract using Chainlink Oracle, a decentralized data network.

The Problem
Currently, the fundMe contract requires at least 1 ETH for transactions. If we want users to transact with a minimum of $5, we need a way to convert between USD and ETH. However, Ethereum doesn’t inherently support USD conversion because it only understands on-chain data (like ETH). This creates the Oracle problem—blockchains lack access to off-chain data like real-world currency prices.

Solution: Chainlink

Chainlink, a decentralized Oracle network, bridges this gap. It securely connects smart contracts with off-chain data, ensuring reliable data transmission without central points of failure.

Here's how its features help:

Data Feeds: Aggregate cryptocurrency price data from exchanges and deliver accurate pricing to smart contracts (like ETH/USD conversion).
VRF (Randomness): Provides provable randomness for fair lotteries, gaming, and NFTs.
Automation (Keepers): Automatically triggers smart contract actions based on predefined conditions.
Functions: Allows smart contracts to make API calls to fetch external data for advanced use cases.
Chainlink in FundMe: Using Chainlink Data Feeds, the fundMe contract can fetch live ETH/USD prices to enable currency conversion. This ensures users can fund the contract with $5 worth of ETH, improving flexibility and usability.

Conclusion Chainlink solves the Oracle problem while offering additional tools like randomness, automation, and API integration to create feature-rich decentralized applications. It’s a powerful choice for enhancing blockchain projects.
