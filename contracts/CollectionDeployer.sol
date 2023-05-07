// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "./Collection.sol";


// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract CollectionDeployer is OwnableUpgradeable {

    event CollectionCreated(address collection, string name, string symbol);
    event TokenMinted(address collection, address recipient, uint256 tokenId, string tokenURI);

    function initialize() external initializer {
        __Ownable_init();
    }

    function deployCollection(string memory name, string memory symbol, string memory baseURI) external onlyOwner {
        Collection collection = new Collection();
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(collection),
            address(msg.sender),
            abi.encodeWithSelector(Collection.initialize.selector, name, symbol, baseURI)
        );

        emit CollectionCreated(address(proxy), name, symbol);
    }

    function mint(Collection collection, address to, uint256 tokenId) external onlyOwner {
        collection.mint(to, tokenId);

        emit TokenMinted(address(collection), to, tokenId, collection.tokenURI(tokenId));
    }
}