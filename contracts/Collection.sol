// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Collection is ERC721Upgradeable, OwnableUpgradeable {
    string internal baseURI;

    function initialize(string memory name, string memory symbol, string memory baseURI_) external initializer {
        baseURI = baseURI_;

        __Ownable_init();
        __ERC721_init(name, symbol);
    }

    function mint(address to, uint256 tokenId) external onlyOwner {
        _safeMint(to, tokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}