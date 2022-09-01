// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Tarefa04.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract SellingFromTarefa04 is Ownable 
{
    Tarefa04 tarefa04Token;

    uint256 public tokensPerMatic = 25;

    event BuyTokens(address buyer, uint256 amountOfMatic, uint256 amountOfTokens);

    constructor(address tokenAddress)
    {
        tarefa04Token = Tarefa04(tokenAddress);
    }

    function buyTokens() public payable returns (uint256 tokenAmount)
    {
        require(msg.value > 0, "Send MATIC to buy some tokens, nothing is free XD");

        uint256 amountToBuy = msg.value * tokensPerMatic;
        uint256 SellerBalance = tarefa04Token.balanceOf(address(this)); // Check se o vendedor tem tokens o suficiente para transação
        require(SellerBalance >= amountToBuy, "O vendedor nao possui tokens o suficiente para a transacao");

        (bool sent) = tarefa04Token.transfer(msg.sender, amountToBuy); // Transferir o token...
        require(sent, "Falhou a transferencia do(s) token(s) para o usuario");

        emit BuyTokens(msg.sender, msg.value, amountToBuy); // emitir o evento

        return amountToBuy;
    }

    function withdraw() public onlyOwner
    {
        uint256 ownerBalance = address(this).balance;
        require(ownerBalance > 0, "O Dono do tolen nao tem fundos o suficiente para realizar o saque");

        (bool sent,) = msg.sender.call{value: address(this).balance}("");
        require(sent, "O usuario falhou em enviar os fundos de volta ao dono");
    }
}
