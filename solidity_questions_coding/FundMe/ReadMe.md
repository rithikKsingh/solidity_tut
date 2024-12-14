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

