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
