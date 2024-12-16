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

---
### Interacting with an External Contract

To interact with any external contract, you need the contract's _address_ and _ABI_ (Application Binary Interface). Think of the `address` as a _house number_ that identifies the specific contract on the blockchain, while the `ABI` serves as a _manual_ that explains how to interact with the contract.

To obtain the contract ABI, you can compile a Solidity **interface** that the target contract implements. Then, create a new instance of the interface pointing to the specific address of the deployed contract.

### Chainlink Price Feeds

[Chainlink Price Feeds](https://docs.chain.link/docs/using-chainlink-reference-contracts/) provide a reliable way to access real-world data, such as pricing data, and inject it into smart contracts. This is particularly useful for executing mathematical operations in Solidity and the Ethereum Virtual Machine (EVM), where floating-point numbers are not used.

### Solidity Global Properties

The [Solidity documentation](https://docs.soliditylang.org/en/latest/cheatsheet.html#block-and-transaction-properties) provides several global properties that are essential for interacting with the Ethereum blockchain. Here are two key properties:

* `msg.sender`: this property refers to the address of the account that **initiated the current function call**
* `msg.value`: this property represents the **amount of Wei** sent with a function call

---
### Libraries

Libraries are collections of reusable code designed to be stateless and utility-focused. They typically provide helper functions (e.g., mathematical operations, string manipulation) that can be called from other contracts.

Difference between Libraray and Contract?

The main differences between **Solidity libraries** and **contracts** are rooted in their design, purpose, and behavior in the Ethereum ecosystem. Here's a breakdown:

---

### 1. **Purpose**
   - **Library**:  
     Libraries are collections of reusable code designed to be stateless and utility-focused. They typically provide helper functions (e.g., mathematical operations, string manipulation) that can be called from other contracts.
   - **Contract**:  
     Contracts are the building blocks of decentralized applications (dApps). They define state, business logic, and interactions with users, other contracts, and blockchain data.

---

### 2. **State Management**
   - **Library**:  
     Libraries do not maintain their own state. They operate as **stateless** entities, meaning they only perform computations or actions without storing data.
   - **Contract**:  
     Contracts maintain their own state (storage variables) and can track user-specific or application-specific data over time.

---

### 3. **Deployment**
   - **Library**:  
     Libraries can be deployed once and reused by multiple contracts, reducing deployment costs and enabling modular design. They are deployed as standalone bytecode on the blockchain.
   - **Contract**:  
     Each contract is deployed individually and interacts with the blockchain based on its specific logic and storage.

---

### 4. **Functionality and Calls**
   - **Library**:  
     Functions in libraries are typically **pure** or **view**, meaning they do not modify or depend on blockchain state.  
     - Libraries can be of two types:
       1. **Embedded Library**: Their code is copied into the calling contract during compilation.
       2. **Deployed Library**: Functions are executed via **delegatecall**, allowing the calling contract to execute library code within its own context.
   - **Contract**:  
     Contracts can have state-modifying functions and maintain persistent data. They communicate via **message calls** and cannot use `delegatecall` by default.

---

### 5. **Inheritance**
   - **Library**:  
     Libraries cannot be inherited or extend other libraries or contracts. However, they can be used directly by contracts via the `using for` directive.
   - **Contract**:  
     Contracts can inherit from other contracts, enabling code reuse, modularization, and polymorphism.

---

### 6. **Gas Costs**
   - **Library**:  
     - Using an embedded library adds gas costs during deployment because its code is inlined.  
     - Deployed libraries reduce deployment costs for the calling contract because the library code is reused and does not increase the contract's size.
   - **Contract**:  
     Contracts incur their full deployment cost, including all logic, functions, and state variables.

---

### 7. **`selfdestruct` Behavior**
   - **Library**:  
     Libraries cannot use `selfdestruct`, as they are intended to be stateless and utility-driven.
   - **Contract**:  
     Contracts can use `selfdestruct` to delete their bytecode and free up storage on the blockchain.

---

### 8. **Example Code**
#### **Library Example**:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLib {
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }
}
```

#### **Contract Example**:
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    uint256 public total;

    function add(uint256 a, uint256 b) public {
        total = a + b;
    }
}
```

---

### **Key Summary Table**

| **Feature**            | **Library**                      | **Contract**                   |
|-------------------------|-----------------------------------|---------------------------------|
| **Purpose**             | Utility-focused, reusable code   | dApp logic and state management|
| **State Management**    | Stateless                        | Stateful                       |
| **Deployment**          | Deployed once, reused by contracts | Deployed individually          |
| **Inheritance**         | Cannot inherit or be inherited   | Can inherit other contracts    |
| **Function Execution**  | `delegatecall` or inline in contract | Independent execution          |
| **Gas Costs**           | Lower if reused, higher if inlined | Standard                       |
| **`selfdestruct`**      | Not allowed                      | Allowed                        |

Let me know if you’d like more clarification on any of these points!
