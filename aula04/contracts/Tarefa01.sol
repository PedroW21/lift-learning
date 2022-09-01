// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract Tarefa01 is ERC20
{
    constructor() ERC20("HelloWorldOfDefi","HWOD")
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}