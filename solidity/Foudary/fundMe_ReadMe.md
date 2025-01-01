### Project setup
create a new folder(ex- foundry-fund-me) -> move to it -> ```forge init```

---

### smart contracts testing
  
#### Counter.sol

It's a simple smart contract that stores a number. You have a function to `setNumber` where you specify a `newNumber` which is a `uint256`, and store it, and you have a function to `increment` the number.

**Note:** `number++` is equivalent to `number = number + 1`.

#### Counter.s.sol

Just a placeholder, it doesn't do anything

#### Counter.t.sol

This is the interesting part. We haven't talked that much about carrying tests using Foundry. This is an essential step for any project. The `test` folder will become our new home throughout this course.

Please run the following command in your terminal:

```Solidity
forge test
```

After the contracts are compiled you will see an output related to tests:

* How many tests were found;
* In which file;
* Did they pass or not?;
* Summary;

### How does `forge test` work?

`forge test` has a lot of options that allow you to configure what is tested, how the results are displayed, where is the test conducted and many more!

Run `forge test --help` to explore the options.

In short, in our specific case:

1. Forge identified all the files in the test folder, went into the only file available and ran the `setUp` function.
2. After the setup is performed it goes from top to bottom in search of public/external functions that start with `test`.
3. All of them will be called and the conclusion of their execution will be displayed. By that we mean it will run all the `assert` statements it can find and if all evaluate to `true` then the test will pass. If one of the `assert` statements evaluates to `false` the test will fail.

---
### Finishing the setup

Please delete the `Counter` files that Foundry prepopulated in our new project.

In `src` create two files, `FundMe.sol` and `PriceConverter.sol`.

Go on the [Remix Fund Me repo](https://github.com/Cyfrin/remix-fund-me-f23) and copy the contents of both contracts.

Try running `forge compile` or `forge build`. A few errors will pop up. What's the problem?

If you open both the copied smart contracts you will see that up top we `import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";`. This wasn't a problem in Remix because Remix automatically takes care of this problem for you. In Foundry you have to manually install all your dependencies.

`forge install` is the command we are using to install one or multiple dependencies.&#x20;

Call the following:

```Solidity
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
```
in case you dont want to write the version:
```Solidity
forge install smartcontractkit/chainlink-brownie-contracts --no-commit
```

Wait for it to finish.

We used `forge install` to ask Forge to install something in our project. What? We specified the path to a GitHub repository, this also could have been a raw URL. What version? Following the path to a GitHub repository you can add an `@` and then you can specify:

* A branch: master
* A tag: v1.2.3.4 or 0.6.1 in our case
* A commit: 8e8128

If we open the `lib` folder, we can see the `forge-std` which is installed automatically within the `forge init` setup and `chainlink-brownie-contracts` which we just installed. Look through the former, you'll see a folder called `contracts` then a folder called `src`. Here you can find different versions, and inside them, you can find a plethora of contracts, some of which we are going to use in this course. Here we can find the `AggregatorV3Interface` that we are importing in `FundMe.sol`.

But if you open the `FundMe.sol` you'll see that we are importing `{AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";` not from  `/foundry-fund-me-f23/lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol`. How does Foundry know `@chainlink` to half of the path?

Open `foundry.toml`. Below the last line of `[profile.default]` paste the following:

```toml
remappings = ['@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/']
```

Now Forge knows to equivalate these. Let's try to compile now by calling `forge compile` or `forge build`.

**Awesome! Everything complies.**

Fixing dependencies in projects is one of the most undesirable things in smart contracts development/audit. Take it slow, make sure you select the proper GitHub repository path, make sure your remappings are solid and they match your imports and everything will be fine!
