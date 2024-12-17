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


---
### Integer Overflow

`SafeMath.sol` was a staple in Solidity contracts before version 0.8. After this version, its usage has significantly dropped.

```
// SafeMathTester.sol
pragma solidity ^0.6.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        bigNumber = bigNumber + 1; //bigNumber=0
    }
}
```

Before Solidity version **0.8.0**, signed and unsigned integers were **unchecked**, meaning that if they exceeded the maximum value the variable type could hold, they would reset to the lower limit. This pattern is known as **integer overflow** and the `SafeMath` library was designed to prevent it.

### SafeMath

`SafeMath.sol` provided a mechanism to revert transactions when the maximum limit of a `uint256` data type was reached. It was a typical security measure across contracts to avoid erroneous calculations and potential exploits.

```
function add(uint a, uint b) public pure returns (uint) {
    uint c = a + b;
    require(c >= a, "SafeMath: addition overflow");
    return c;
}
```

### Solidity 0.8.0

With the introduction of Solidity version 0.8, automatic checks for overflows and underflows were implemented, making `SafeMath` redundant for these checks. If `SafeMathTester.sol` is deployed with Solidity `0.8.0`, invoking the `add` function will cause a transaction to fail, when, in older versions, it would have reset to zero.

For scenarios where mathematical operations are known not to exceed a variable's limit, Solidity introduced the `unchecked` construct to make code more _gas-efficient_. Wrapping the addition operation with `unchecked` will _ignore the overflow and underflow checks_: if the `bigNumber` exceeds the limit, it will wrap its value to zero.

```solidity
uint8 public bigNumber = 255;

function add() public {
    unchecked {
        bigNumber = bigNumber + 1;
    }
}
```

🔥 **CAUTION**:br
It's important to use unchecked blocks with caution as they reintroduce the possibility of overflows and underflows.

----

### Sending ETH from one account to another: `transfer`, `send`, and `call`
### 1. Transfer

The `transfer` function is the simplest way to send Ether to a recipient address:

```
payable(msg.sender).transfer(amount); // the current contract sends the Ether amount to the msg.sender

```
It's necessary to convert the recipient address to a **payable** address to allow it to receive Ether. This can be done by wrapping `msg.sender` with the `payable` keyword.

However, `transfer` has a significant limitation. It can only use up to 2300 gas and it reverts any transaction that exceeds this gas limit.

### 2. Send

The `send` function is similar to `transfer`, but it differs in its behaviour:
```
bool success = payable(msg.sender).send(address(this).balance);
require(success, "Send failed");
```
Like `transfer`, `send` also has a gas limit of 2300. If the gas limit is reached, it will not revert the transaction but return a boolean value (`true` or `false`) to indicate the success or failure of the transaction. It is the developer's responsibility to handle failure correctly, and it's good practice to trigger a **revert** condition if the `send` returns `false`.

### 3. Call

The `call` function is flexible and powerful. It can be used to call any function **without requiring its ABI**. It does not have a gas limit, and like `send`, it returns a boolean value instead of reverting like `transfer`.

```solidity
(bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
require(success, "Call failed");
```
To send funds using the `call` function, we convert the address of the receiver to `payable` and add the value inside curly brackets before the parameters passed.

The `call` function returns two variables: a boolean for success or failure, and a byte object which stores returned data if any.

> 👀❗**IMPORTANT**:br
> `call` is the recommended way of sending and receiving Ethereum or other blockchain native tokens.


---
### Modifiers
If we build a contract with multiple _administrative functions_, that should only be executed by the contract owner, we might repeatedly check the caller identity:
```
require(msg.sender == owner, "Sender is not owner");
```

However, repeating this line in every function clutters the contract, making it harder to read, maintain, and debug.

* Modifiers
Modifiers in Solidity allow embedding **custom lines of code** within any function to modify its behaviour.

```
modifier onlyOwner {
    require(msg.sender == owner, "Sender is not owner");
    _;
}
```
### The `_` (underscore)

The underscore `_` placed in the body is a placeholder for the modified function's code. When the function with the modifier is called, the code before `_` runs first, and if it succeeds, the function's code executes next.

For example, the `onlyOwner` modifier can be applied to the `withdraw` function like this:

function withdraw(uint amount) public onlyOwner {
    // Function logic
}

When `withdraw` is called, the contract first executes the `onlyOwner` modifier. If the `require` statement passes, the rest of the `withdraw` function executes.

If the underscore `_` were placed before the `require` statement, the function's logic would execute first, followed by the `require` check, which is not the intended use case.

---
### Optimizing Variables (to make contract gas efficient)

The variables `owner` and `minimumUSD` are set one time and they never change their value: `owner` is assigned during contract creation, and `minimumUSD` is initialized at the beginning of the contract.

### Evaluating the FundMe Contract

We can evaluate the gas used to create the contract by deploying it and observing the transaction in the terminal. In the original contract configuration, we spent almost 859,000 gas.

### Constant

To reduce gas usage, we can use the keywords `constant` and `immutable`. These keywords ensure the variable values remain unchanged.

We can apply these keywords to variables assigned once and never change. For values known at **compile time**, use the `constant` keyword. It prevents the variable from occupying a storage slot, making it cheaper and faster to read.

Using the `constant` keyword can save approximately 19,000 gas, which is close to the cost of sending ETH between two accounts.

> 🗒️ **NOTE**:br
> Naming conventions for `constant` are all caps with underscores in place of spaces (e.g., `MINIMUM_USD`).

> 🚧 **WARNING**:br
> Converting the current ETH gas cost to USD, we see that when ETH is priced at 3000 USD, defining `MINIMUM_USD` as a constant costs 9 USD, nearly 1 USD more than its public equivalent.

### Immutable

While `constant` variables are for values known at compile time, `immutable` can be used for variables set at deployment time that will not change(i.e you set them only once). The naming convention for `immutable` variables is to add the prefix `i_` to the variable name (e.g., `i_owner`).

Comparing gas usage after making `owner` an `immutable` variable, we observe similar gas savings to the `constant` keyword.

---
### Require

One way to improve gas efficiency is by optimizing our `require` statements. Currently, the `require` statement forces us to store the string 'sender is not an owner'. Each character in this string is stored individually, making the logic to manage it complex and expensive.

### Custom Errors

Introduced in **Solidity 0.8.4**, custom errors can be used in `revert` statements. These errors should be declared at the top of the code and used in `if` statements. The cheaper error code is then called in place of the previous error message string, reducing gas costs.

We can start by creating a custom error:

```solidity
error NotOwner();
```
Then, we can replace the `require` function with an `if` statement, using the `revert` function with the newly created error:

```
if (msg.sender != i_owner) {
    revert NotOwner();
}
```

By implementing custom errors, we reduce gas costs and simplify error handling in our smart contracts.

---
### receive and fallback functions

`receive` and `fallback` are _special functions_ triggered when users send Ether directly to the contract or call non-existent functions. These functions do not return anything and must be declared `external`

```
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}
```
In this contract, `result` is initialized to zero. When Ether is sent to the contract, the `receive` function is triggered, setting `result` to one.
If a transaction includes **data** but the specified function _does not exist_, the `fallback` function will be triggered, setting `result` to two.

// Ether is sent to contract
//      is msg.data empty?
//          /   \
//         yes  no
//         /     \
//    receive()?  fallback()
//     /   \
//   yes   no
//  /        \
//receive()  fallback()

<img width="294" alt="Screenshot 2024-12-17 at 10 01 20 PM" src="https://github.com/user-attachments/assets/e73471e5-78c3-4567-81a6-11ddb5b724bd" />

* What does it happen when Ether is sent with _data_ but in the contract only a `receive` function exist?
-> a pop up will appear saying 'fallback function' doesn't exists. 
