// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.8.2/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.8.2/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.8.2/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@4.8.2/access/Ownable.sol";
import "@openzeppelin/contracts@4.8.2/utils/cryptography/draft-EIP712.sol";
import "@openzeppelin/contracts@4.8.2/token/ERC721/extensions/draft-ERC721Votes.sol";
import "@openzeppelin/contracts@4.8.2/utils/Counters.sol";

/// @custom:security-contact ncmtriet@gmail.com
contract NFTDAO is ERC721, ERC721Enumerable, ERC721URIStorage, ERC721Burnable, Ownable, EIP712, ERC721Votes {

    struct TokenInfo {
        IERC20 paytoken;
        uint256 costvalue;
    }

    TokenInfo[] public AllowedCrypto;
    
    using Strings for uint256;
    string public baseURI;
    string public baseExtension = ".json";
    uint256 public cost = 0.001 ether;
    uint256 public maxSupply = 1000;
    uint256 public maxMintAmount = 5;
    bool public paused = false;
    
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Investment DAO", "ID") EIP712("NFT DAO", "1") {}

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _afterTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Votes)
    {
        super._afterTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
