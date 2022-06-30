// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Transactions {

    // state variables
    address public owner;
    mapping (address => uint) public stockBalances;

    // set the owner as th address that deployed the contract
    // set the initial stock balance to 100
    constructor() {
        owner = msg.sender;
        stockBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return stockBalances[address(this)];
    }

    // Let the owner restock the store
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock.");
        stockBalances[address(this)] += amount;
    }

    // Purchase stock from the store
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ETH per unit");
        require(stockBalances[address(this)] >= amount, "Not enough stock to complete this purchase");
        stockBalances[address(this)] -= amount;
        stockBalances[msg.sender] += amount;
    }
}