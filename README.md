# Collection Deployer Contracts

## Compile and Test Contracts
To test the contracts, run the following commands:

```
npm install
npx hardhat test
```

## Deploy Contracts

To deploy the contracts on a local ganache network you need to first run ganache:

```
ganache --port 8545 -h=0.0.0.0 -m="rifle cloud amused end pyramid swarm anxiety kitchen ceiling cotton rib gain"
```

Then run the following command to deploy the contract:

```shell
cp .env.example .env
npx hardhat --network localhost deploy --tags deploy
```
