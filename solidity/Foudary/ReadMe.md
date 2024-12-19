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


