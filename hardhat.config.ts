import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import { config as dotenvConfig } from "dotenv";
import { resolve } from "path";
import "@nomiclabs/hardhat-ethers";

dotenvConfig({ path: resolve(__dirname, "./.env") });

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    localhost: {
      accounts: [process.env.PRIVATE_KEY || ""],
      chainId: 1337,
      url: "http://localhost:8545",
    }
  },
  namedAccounts: {
    deployer: {
        default: 0,
    },
  },

};

export default config;
