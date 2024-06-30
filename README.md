# GameToken Smart Contract

## Simple Overview
This project implements a custom ERC20 token called `GameToken` using the OpenZeppelin library. The smart contract includes functionalities to register players, mint new tokens for registered players, burn tokens from registered players, and transfer tokens between registered players, all while enforcing ownership rules.

## Description
GameToken is an ERC20-compliant smart contract developed in Solidity. It leverages OpenZeppelin's robust libraries to ensure security and reliability. The contract features public functions for registering players, minting tokens, burning tokens, transferring tokens, and querying player token balances, with specific permissions enforced by the `onlyOwner` modifier.

### Key Features
- **ERC20 Compliance**: Inherits standard ERC20 functionality from OpenZeppelin.
- **Ownership Management**: Utilizes OpenZeppelin's `Ownable` contract to manage contract ownership.
- **Player Registration**: Allows the contract owner to register players.
- **Decimal Customization**: Overrides the `decimals` function to set the token decimals to zero.
- **Minting and Burning**: Allows the owner to mint tokens for registered players and any registered player to burn their tokens.
- **Transfer Function**: Allows registered players to transfer tokens to other registered players.

### Key Functions and Statements
- **`require`**: Ensures conditions are met before executing certain functions, reverting the transaction if conditions are not met.
- **`onlyOwner`**: A modifier that restricts certain functions to be called only by the contract owner.

## Getting Started

### Installing
1. **Download the Project**
   - Clone the repository from GitHub:
     ```sh
     git clone https://github.com/spiritcoder.666/ETH_AVAX_INTER_MOD_3.git
     ```
   - Navigate to the project directory:
     ```sh
     cd ETH_AVAX_INTER_MOD_3
     ```

2. **Open Remix IDE**
   - Go to [Remix IDE](https://remix.ethereum.org/).
   - In the file explorer, create a new file named `GameToken.sol`.

3. **Copy and Paste the Smart Contract Code**
   - Copy the following code and paste it into `GameToken.sol`:
     ```solidity
     // SPDX-License-Identifier: MIT
     pragma solidity ^0.8.20;

     import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
     import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
     import "@openzeppelin/contracts/access/Ownable.sol";

     // Functionality
     // Only contract owner should be able to mint tokens
     // Any user can transfer tokens
     // Any user can burn tokens

     // Author : Rohit

     contract GameToken is ERC20, Ownable {

         struct Player {
             bool registered;
         }

         mapping(address => Player) public players;

         constructor()
             ERC20("Rohit", "RM")
             Ownable(msg.sender)
         {
             transferOwnership(msg.sender);
         }

         function decimals() public view virtual override returns (uint8) {
             return 0;
         }

         function registerPlayer(address player) public onlyOwner {
             require(!players[player].registered, "Player is already registered");
             players[player].registered = true;
         }

         function mint(address to, uint256 amount) public onlyOwner {
             require(players[to].registered, "Player is not registered");
             _mint(to, amount);
         }

         function burn(address from, uint256 amount) public {
             require(players[from].registered, "Player is not registered");
             require(amount <= balanceOf(from), "Insufficient balance to burn");

             _burn(from, amount);
         }

         function transferPoints(address from, address to, uint256 amount) public {
             require(players[from].registered, "Sender is not registered");
             require(players[to].registered, "Receiver is not registered");
             require(amount <= balanceOf(from), "Insufficient balance to transfer");

             _transfer(from, to, amount);
         }

         function getPlayerPoints(address player) public view returns (uint256) {
             require(players[player].registered, "Player is not registered");
             return balanceOf(player);
         }

         function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
             return super.transferFrom(from, to, amount);
         }
     }
     ```

### Executing Program

#### How to Run the Program in Remix
1. **Compile the Smart Contract**
   - Select the `Solidity Compiler` tab.
   - Ensure the compiler version is set to `0.8.20`.
   - Click `Compile GameToken.sol`.

2. **Deploy the Contract**
   - Go to the `Deploy & Run Transactions` tab.
   - Select the appropriate environment (e.g., JavaScript VM).
   - Click `Deploy`.

3. **Interact with the Contract**
   - After deploying, the contract will appear under `Deployed Contracts`.
   - To register a player:
     - Input the player's address.
     - Click the `registerPlayer` button.
   - To mint tokens:
     - Input the player's address and the amount of tokens to mint.
     - Click the `mint` button.
   - To burn tokens:
     - Input the player's address and the amount of tokens to burn.
     - Click the `burn` button.
   - To transfer tokens:
     - Input the sender's address, receiver's address, and the amount of tokens to transfer.
     - Click the `transferPoints` button.
   - To get player points:
     - Input the player's address.
     - Click the `getPlayerPoints` button.

## Help

### Common Issues
- **Compilation Errors**: Ensure the Solidity version specified matches the version set in the Remix compiler.
- **Deployment Errors**: Make sure the selected environment is correct and the contract is compiled without errors.
- **Interaction Errors**: Ensure the address and value inputs are valid, that players are registered, and that sufficient balance exists for burning or transferring tokens.

For detailed debugging and assistance, refer to the Remix documentation or community forums.

## Authors
- **Rohit**
  - GitHub: [NICxKMS](https://github.com/spiritcoder.666)
 

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
