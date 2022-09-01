const { expect } = require("chai");

describe("Token contract - SellingFromTarefa04", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("SellingFromTarefa04");

    const hardhatToken = await Token.deploy("0x83F842810dD660c5bbF499B7A488f4715173C523");

    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });
});