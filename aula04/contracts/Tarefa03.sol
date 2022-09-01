// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract Tarefa03 is ERC20
{
    uint256 TIME_BLOCK = 1672531201; // Data e tempo (em GMT) para: Domingo, 1 de janeiro de 2023, 00h00min01s
    address public contractOwner;

    constructor() ERC20("TheThirdContract", "TTC") 
    {
        contractOwner = msg.sender;
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    modifier checkBlock()
    {
        require(msg.sender == contractOwner || block.timestamp > TIME_BLOCK, "Must wait until Jan/2023");
        _;
    }

    function transfer(address to, uint256 amount) public checkBlock virtual override returns (bool) 
    {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public checkBlock virtual override returns (bool) 
    {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
}