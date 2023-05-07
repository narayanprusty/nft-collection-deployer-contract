import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { CollectionDeployer } from "../typechain-types";

describe("CollectionDeployer", function () {

  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployCollectionDeployer() {

    const CollectionDeployerFactory = await ethers.getContractFactory("CollectionDeployer");
    const collectionDeployer:CollectionDeployer = await CollectionDeployerFactory.deploy();
    await collectionDeployer.initialize();


    return { collectionDeployer };
  }

  describe("Deployment and Mint", function () {
    it("Should deploy NFT collection and mint token", async function () {
      const [_, user] = await ethers.getSigners();

      const { collectionDeployer } = await loadFixture(deployCollectionDeployer);
      const tx = await collectionDeployer.deployCollection("Test", "TST", "http://test.com/");
      const receipt = await tx.wait()
      
      const events = receipt.events?.filter((_) => {return _.event == "CollectionCreated"})
      expect(events?.length).to.be.equal(1);

      const collectionAddress = events[0].args[0];
      expect(collectionAddress).to.be.not.equal("");

      await expect(collectionDeployer.mint(collectionAddress, user.address, 1)).to.emit(collectionDeployer, "TokenMinted").withArgs(
        collectionAddress, user.address, 1, "http://test.com/1"
      )
    });
  });
});
