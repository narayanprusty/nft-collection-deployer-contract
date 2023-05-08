// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Collection is ERC721Upgradeable, OwnableUpgradeable {
    string internal baseURI;

    /**
     * @notice Initalize the Collection contract
     * @param name name of the collection
     * @param symbol symbol of the collection
     * @param baseURI_ base uri of the collection
     */
    function initialize(string memory name, string memory symbol, string memory baseURI_) external initializer {
        baseURI = baseURI_;

        __Ownable_init();
        __ERC721_init(name, symbol);
    }

    /**
     * @notice Mint a token in the collection
     * @param to recipient of the token
     * @param tokenId id of the token
     */
    function mint(address to, uint256 tokenId) external onlyOwner {
        _safeMint(to, tokenId);
    }

    /**
     * @notice Used to get the base uri of the collection
     * @return baseURI base uri of the collection
     */
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}