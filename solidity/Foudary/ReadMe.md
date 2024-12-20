### Creating a New Project

The way you [create a new Foundry project](https://book.getfoundry.sh/projects/creating-a-new-project) is by running the `forge init` command. This will create a new Foundry project in your current working directory.

If you want Foundry to create the new project in a new folder type `forge init nameOfNewFolder`.

Keep in mind that by default `forge init` expects an empty folder. If your folder is not empty you must run `forge init --force .`


And that's it, your folder should look as follows:

<img width="619" alt="Screenshot 2024-12-19 at 3 29 25 PM" src="https://github.com/user-attachments/assets/54df063a-f4e1-439a-852e-86358539cfb7" />

`lib` is the folder where all your dependencies are installed, here you'll find things like:

* `forge-std` (the forge library used for testing and scripting)
* `openzeppelin-contracts` is the most battle-tested library of smart contracts
* and many more, depending on what you need/install

`scripts` is a folder that houses all your scripts

`src` is the folder where you put all your smart contracts

`test` is the folder that houses all your tests

`foundry.toml` - gives configuration parameters for Foundry

### Compiling Smart Contracts: A Guide to the Foundry Console Compilation Process

Open a new terminal. Type in `forge build` or `forge compile` to compile the smart contracts in your project.

Once the compiling is finished, you'll see some new folders in the Explorer tab on the left side. One of them is a folder called `out`. Here you'll be able to find the [ABI](https://docs.soliditylang.org/en/latest/abi-spec.html) of the smart contract together with the [Bytecode](https://www.geeksforgeeks.org/introduction-to-bytecode-and-opcode-in-solidity/) and a lot of useful information.

The `cache` folder also appears. Generally, this folder is used to store temporary system files facilitating the compilation process. But for this course, you can safely ignore it.

### Deploying a smart contract

There are multiple ways and multiple places where you could deploy a smart contract.

While developing using the Foundry framework the easiest and most readily available place for deployment is Anvil.

Anvil is a local testnet node shipped with Foundry. You can use it for testing your contracts from frontends or for interacting over RPC.

To run Anvil you simply have to type `anvil` in the terminal.

You now have access to 10 test addresses funded with 10\_000 ETH each, with their associated private keys.

This testnet node always listens on `127.0.0.1:8545` this will be our `RPC_URL` parameter when we deploy smart contracts here. More on this later!

### Ganache
Ganache is a personal blockchain for rapid Ethereum and Filecoin distributed application development. You can use Ganache across the entire development cycle; enabling you to develop, deploy, and test your dApps in a safe and deterministic environment.


### Configuring MetaMask

To deploy to a custom network (like your localhost), you'll need MetaMask. MetaMask is a popular cryptocurrency wallet and browser extension that allows users to interact with the Ethereum blockchain and its ecosystem.

Follow these steps:

1. Open MetaMask.

2. Click the three little dots and select 'Expand View'.

3. Go to 'Settings', then 'Networks'.

4. Here, you'll see the list of networks (Ethereum, Mainnet, etc.) with plenty of details about each one. Locate the RPC URL - this is key.

The RPC URL is essentially the endpoint we make API calls to when sending transactions. For every blockchain transaction you execute, you're making an API to whatever is in here.
To send a transaction to your custom blockchain, you need to add it as a network:

1. Click on 'Add a Network'

2. Scroll to the bottom of the list of networks.

3. Hit 'Add a Network manually'.

4. Enter the details of your local network

   Network name: `Localhost`

   New RPC URL: Ganache`http://127.0.0.1:7545` or Anvil `http://127.0.0.1:8545` (make sure you always add `http://`) - these two could differ on your machine, please consult the Ganache UI or Anvil terminal for the exact RPC URL.

   Chain ID: Ganache `5777`(sometimes `1337`) or Anvil `31337` - these two could differ on your machine, please consult the Ganache UI or Anvil terminal for the exact Chain ID.

   Currency symbol: ETH

   Block explorer URL: - (we don't have a block explorer for our newly created blockchain, which will most likely disappear when we close the VS Code / Ganache app)

Great! Now that we configured our local network, the next step is to add one of the accounts available in Ganche or Anvil into our MetaMask. [This is done as follows](https://support.metamask.io/hc/en-us/articles/360015489331-How-to-import-an-account#h_01G01W07NV7Q94M7P1EBD5BYM4):

1. Click the account selector at the top of your wallet.

2. Click `Add account or hardware wallet`.

3. Click `Import account`

4. You will be directed to the Import page. Paste your Ganache/Anvil private key. Click `Import`.

**NOTE: Do not use this account for anything else, do not interact with it or send things to it on mainnet or any other real blockchain, use it locally, for testing purposes. Everyone has access to it.**

### Deploying to a local blockchain

To find out more about forge's capabilities type

```Solidity
forge --help
```

Out of the resulting list, we are going to use the `create` command.

Type `forge create --help` in the terminal or go [here](https://book.getfoundry.sh/reference/forge/forge-create) to find out more about the available configuration options.

Try running `forge create SimpleStorage`. It should fail because we haven't specified a couple of required parameters:

1. `Where do we deploy?`

2. `Who's paying the gas fees/signing the transaction?`

Let's tackle both these questions.

Each blockchain (private or public) has an RPC URL (RPC SERVER) that acts as an endpoint. When we tried to deploy our smart contract, forge tried to use `http://localhost:8545/`, which doesn't host any blockchain. Thus, let's try to deploy our smart contract specifying the place where we want to deploy it.

Start Ganache and press `Quickstart Ethereum`. Copy the RPC Server `HTTP://127.0.0.1:7545`. Let's run our forge create again specifying the correct rpc url.

```
forge create SimpleStorage --rpc-url http://127.0.0.1:7545
```

This again failed, indicating the following:

```Solidity
Error accessing local wallet. Did you set a private key, mnemonic or keystore?
```

Try the following command:

```Solidity
forge create SimpleStorage --rpc-url http://127.0.0.1:7545 --interactive
```

You will be asked to enter a private key, please paste one of the private keys available in Ganache. When you paste a key you won't see the text or any placeholder symbols, just press CTRL(CMD) + V and then ENTER.

You can go to Ganache and check the `Blocks` and `Transactions` tabs to see more info about what you just did.

On Anvil
Do the following:

1. Run `clear`
2. Run `anvil`
3. Create a new terminal by pressing the `+` button
4. Copy one of the private keys from the anvil terminal
5. Run `forge create SimpleStorage --interactive`
   We don't need to specify an `--rpc-url` this time because forge defaults to Anvil's RPC URL.
   (If that doesn't work, use `forge create SimpleStorage --interactive --broadcast`.It's a new command)
7. Go to the Anvil terminal and check the deployment details:

The more explicit way to deploy using `forge create` is as follows:

```Solidity
forge create SimpleStorage --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

We included the `--rpc-url` to not count on the default and the `--private-key` to not use the `--interactive` option anymore.


### Practicing Private Key Safety

Having a private key in plain text is extremely bad. The private key(s) we used in the last lesson are well-known keys for local testing, you shouldn't use those on mainnet and keeping them in plain text is ok, but any other private key should be kept hidden, especially your production key or key's associated with accounts that hold crypto.

Moreover, it's very bad to have private keys in bash history (hit the up arrow and see the key you used to deploy).

You can delete your history by typing:

```Solidity
history -c
```
---
### Deploy a smart contract locally using Anvil via scripts

Deploying a smart contract via scripting is particularly handy because it provides a consistent and repeatable way to deploy reliably and its features enhance the testing of both the deployment processes and the code itself.

In Foundry we keep our scripts in the `script` folder.

Create a new file called `DeploySimpleStorage.s.sol`.
Using `.s.sol` as a suffix is a naming convention for Foundry scripts, sometimes we use `.t.sol`.

// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

```solidity
contract DeploySimpleStorage is Script {
    function run() external returns (SimpleStorage) {
        vm.startBroadcast();

        SimpleStorage simpleStorage = new SimpleStorage();

        vm.stopBroadcast();
        return simpleStorage;
    }
```

}

For it to be considered a Foundry script and to be able to access the extended functionality Foundry is bringing to the table we need to import `Script` from `"forge-std/Script.sol"` and make `DeploySimpleStorage` inherit `Script`.

**NOTE**: `forge-std` also called Forge Standard Library is a collection of pre-written Solidity contracts designed to simplify and enhance scripting and testing within the Foundry development framework.

Furthermore, to be able to deploy `SimpleStorage` we also need to import it by typing `import {SimpleStorage} from "../src/SimpleStorage.sol";`

Every script needs a main function, which, according to the best practice linked above is called `run`. Whenever you run `forge script` this is the function that gets called.

`run` is an external function that will return the `SimpleStorage` contract.

In the Run function, we are going to use a distinctive keyword: `vm`. Foundry has a distinctive feature known as cheat codes. The `vm` keyword is a cheat code in Foundry, and thereby only works in Foundry.

`vm.startBroadcast` indicates the starting point for the list of transactions that get to be sent to the `RPC URL`;

Similarly, `vm.stopBroadcast` indicates the ending point of the list of transactions that get to be sent to the `RPC URL`;

Between those two we write:

`SimpleStorage simpleStorage = new SimpleStorage();`

The `new` keyword is used to create a new smart contract in Solidity.

Please select the `Anvil` terminal and press `CTRL(CMD) + C` to stop it. Now run the following command


```bash
forge script script/DeploySimpleStorage.s.sol
```
This should go through without any errors, but if you hit some errors related to `incompatible solidity versions in various files`

You should get the following output:
```bash
[⠆] Compiling...
[⠔] Compiling 2 files with 0.8.19
[⠒] Solc 0.8.19 finished in 1.08s
Compiler run successful!
Script ran successfully.
Gas used: 338569

== Return ==
0: contract SimpleStorage 0x90193C961A926261B756D1E5bb255e67ff9498A1

If you wish to simulate on-chain transactions pass a RPC URL.
```

**The million-dollar question**: If we didn't pass an RPC URL, where did this deploy to?

If the RPC URL is not specified, Foundry automatically launches an Anvil instance, runs your script (in our case deployed the contract) and then terminates the Anvil instance.

Run the `anvil` command in the terminal, open up a new terminal and type the following:

```bash
forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545
```

```bash
No files changed, compilation skipped
EIP-3855 is not supported in one or more of the RPCs used.
Unsupported Chain IDs: 31337.
Contracts deployed with a Solidity version equal or higher than 0.8.20 might not work properly.
For more information, please see https://eips.ethereum.org/EIPS/eip-3855
Script ran successfully.

== Return ==
0: contract SimpleStorage 0x34A1D3fff3958843C43aD80F30b94c510645C316

## Setting up 1 EVM.

==========================

Chain 31337

Estimated gas price: 2 gwei

Estimated total gas used for script: 464097

Estimated amount required: 0.000928194 ETH

==========================

SIMULATION COMPLETE. To broadcast these transactions, add --broadcast and wallet configuration(s) to the previous command. See forge script --help for more.
```

Is it deployed now?

Answer: No, the output indicates this was a simulation. But, we got a new folder out of this, the `broadcast` folder contains information about different script runs in case we forget details.

Hit the up arrow key and add `--broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` at the end.

Our contract is now successfully deployed! Fantastic!

Switch to the `anvil` terminal where you'll see:

```text
    Transaction: 0x73eb9fb4ef7b159e03c50d669c42e2ec4eeaa9358bea0a710cb07168e5192570
    Contract created: 0x5fbdb2315678afecb367f032d93f642f64180aa3
    Gas used: 357088

    Block Number: 1
    Block Hash: 0x8ea564f146e04bb36fc27f0b491223a023b5882d2fcfce3ff85e0dd152e611e4
    Block Time: "Tue, 16 Apr 2024 13:39:51 +0000"
```

### blockchain transactions
a transaction captures details of an activity that has taken place on a blockchain.

On the left side of your screen, in the Explorer tab, you'll find a folder called `broadcast`. Foundry saves all your blockchain interactions here. The `dry-run` folder is used for interactions you made when you didn't have a blockchain running (remember that time when we deployed our contract without specifying an `--rpc-url`). Moreover, the recordings here are separated by `chainId`.

**Note**: The `chainId` is a unique identifier assigned to a specific blockchain network. It is used to distinguish one blockchain from another and is a crucial parameter for ensuring the security and integrity of transactions and interactions on the blockchain.

Click on `run-latest.json`.
Here we can find more details about the last deployment script we ran in our previous lesson. It will show things like `transactionType`, `contractName` and `contractAddress`. Moreover, in the `transaction` section, you can see what we actually sent over to the RPC URL:

```json
   "transaction": {
        "from": "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
        "to": null,
        "gas": "0x714e1",
        "value": "0x0",
        "input": "0x608060...c63430008130033",
        "nonce": "0x0",
        "chainId": "0x7a69",
        "accessList": null,
        "type": null

      }
```

Let's go through each of these:

* `from` is self-explanatory, it's the address we used to sign the transaction;
* `to` is the recipient, in our case is null or address(0), this is the standard destination for when new smart contracts are deployed;
* `gas` is the amount of gas spent. You will see the hex value `0x714e1` (or any other value represented in hex format);

**Quick tip**: Normal humans can't understand hex values like the one indicated above, but there's a quick way to convert these into usual numbers. Run the following command in your terminal: `cast --to-base 0x714e1 dec`. `cast` is a very versatile tool provided by Foundry, type `cast --help` in your terminal to find out more, or go [here](https://book.getfoundry.sh/reference/cast/cast).

* `value` is the transaction value, or the amount of ETH we are sending over. Given that this transaction was made to deploy a contract, the value here is `0x0` or `0`, but we could have specified a value and that would have been the initial balance of the newly deployed contract;

* `data` in this case is the contract deployment code and the contract code. In the excerpt above this was truncated;

* `nonce` is a unique identifier assigned to each transaction sent from a specific account. The nonce is used to ensure that each transaction is processed only once and to prevent replay attacks. `nonce` is incremented with every single transaction;

* `accessList` is a feature of Ethereum to optimize the gas cost of transactions. It contains a list of addresses and associated storage keys that the transaction is likely to access, allowing the EVM to more efficiently compute the gas cost of storage access during the transaction's execution;

* `type` please ignore this for now.

There are other values that play an important part that weren't presented in that list, namely the `v`, `r`, and `s`. These are components of a transaction's signature, which are used to validate the authenticity and integrity of the transaction.

Whenever we send a transaction over the blockchain there's a signature happening, that's where we use our `private key`.

**Important:** Every time you change the state of the blockchain you do it using a transaction. The thing that indicates the change is the `data` field of a transaction.&#x20;

---
### How to not have your private key in the command line
Having our private key in plain text is very bad. What can we do to avoid this, except using the `--interactive` parameter, because we don't want to keep copy-pasting our private key?

**BIG BOLDED DISCLAIMER: What we are about to do is fine for development purposes, do not put a real key here, it very terrible for production purposes.**

Create a new file in the root of your project called `.env`. Then, go the `.gitignore` file and make sure `.env` is in there.

The `.env` file will host environment variables. Variables that are of a sensitive nature that we don't want to expose in public.

Open the file and put the following in it:
```env
PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

RPC_URL=http://127.0.0.1:8545
```
Next run `source .env`. This adds the above-mentioned environment variables into our shell. Now run `echo $PRIVATE_KEY` or `echo $RPC_URL` to check if the values are stored in the shell.

Now we can safely replace the parameters in our `forge script` command:

```bash
forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY
```
This doesn't only hide your private key from plain sight in the command line but also facilitates faster terminal usage, imagine you'd have to copy-paste the `http://127.0.0.1:8545` RPC URL over and over again. It's cleaner this way.

But yes, now we have the private key in plain text in the `.env` file, that's not good.

### How to handle this problem with production code?

Foundry has a very nice option called `keystore`. To read more about it type `forge script --help` in your terminal. Using `forge script --keystore <PATH>` allows you to specify a path to an encrypted store file, encrypted by a password. Thus your private key would never be available in plain text.

Let's agree to the following:

1. For testing purposes use a `$PRIVATE_KEY` in an `.env` file as long as you don't expose that `.env` file anywhere.
2. Where real money is involved use the `--interactive` option or a [keystore file protected by a password](https://github.com/Cyfrin/foundry-full-course-f23?tab=readme-ov-file#can-you-encrypt-a-private-key---a-keystore-in-foundry-yet).
