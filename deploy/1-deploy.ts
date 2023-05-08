import { HardhatRuntimeEnvironment } from "hardhat/types";
import hre from "hardhat";
import { ethers } from "hardhat";
import { CollectionDeployer } from "../typechain-types";

module.exports = async ({getNamedAccounts, deployments} : HardhatRuntimeEnvironment) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const result = await deploy("CollectionDeployer", {
    contract: "CollectionDeployer",
    from: deployer,
    log: true,
    deterministicDeployment: false,
    proxy: {
      proxyContract: "OptimizedTransparentProxy",
      execute: {
        methodName: "initialize",
        args: [],
      },
    },
  });

  // const collectionDeployer:CollectionDeployer = await ethers.getContractAt("CollectionDeployer", result.address)
  // let tx = await collectionDeployer.deployCollection("Test", "TST", "http://test.com/")
  // const receipt = await tx.wait(1)
  // const collectionAddress = receipt.events[4].args.collection;

  // console.log("Collection address is: ", collectionAddress)

  // tx = await collectionDeployer.mint(collectionAddress, "0xFbaec94e7663eb57D0196206620a36FC131c943C", 1);
  // await tx.wait(1)

  // console.log("Minted token")
}

module.exports.tags = ['deploy'];