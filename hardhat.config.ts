import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import "@nomiclabs/hardhat-ethers";
import { config as dotenvConfig } from "dotenv";
import { resolve } from "path";

dotenvConfig({ path: resolve(__dirname, "./.env") });

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  networks: {
    localhost: {
      accounts: [process.env.PRIVATE_KEY || ""],
      chainId: 1337,
      url: process.env.RPC_URL || "",
    }
  }
};

export default config;