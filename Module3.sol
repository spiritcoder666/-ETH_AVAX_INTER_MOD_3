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
