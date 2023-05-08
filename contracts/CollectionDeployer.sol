// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "./Collection.sol";


// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract CollectionDeployer is OwnableUpgradeable {

    /// @notice Emitted when new collection is deployed
    event CollectionCreated(address collection, string name, string symbol);

    /// @notice Emitted when a token is minted in a collection
    event TokenMinted(address collection, address recipient, uint256 tokenId, string tokenURI);

    /**
     * @notice Initalize the CollectionDeployer contract
     */
    function initialize() external initializer {
        __Ownable_init();
    }

    /**
     * @notice Deploy a new collection
     * @param name name of the collection
     * @param symbol symbol of the collection
     * @param baseURI base uri of the collection
     */
    function deployCollection(string memory name, string memory symbol, string memory baseURI) external onlyOwner {
        Collection collection = new Collection();
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(collection),
            address(msg.sender),
            abi.encodeWithSelector(Collection.initialize.selector, name, symbol, baseURI)
        );

        emit CollectionCreated(address(proxy), name, symbol);
    }

    /**
     * @notice Mint a token in the collection
     * @param collection address of the collection contract
     * @param to recipient of the token
     * @param tokenId id of the token
     */
    function mint(Collection collection, address to, uint256 tokenId) external onlyOwner {
        collection.mint(to, tokenId);

        emit TokenMinted(address(collection), to, tokenId, collection.tokenURI(tokenId));
    }
}