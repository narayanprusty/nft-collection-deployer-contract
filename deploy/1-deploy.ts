import { HardhatRuntimeEnvironment } from "hardhat/types";
import hre from "hardhat";
import { ethers } from "hardhat";

module.exports = async ({getNamedAccounts, deployments} : HardhatRuntimeEnvironment) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log(deployer)

  await deploy("CollectionDeployer", {
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
}

module.exports.tags = ['deploy'];