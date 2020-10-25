pragma solidity ^0.6.0;

import "./ERC721.sol";


contract PresentERC721 is ERC721 {
    struct Present {
        string Name;
    }

    Present[] public presents;

    constructor(string memory name, string memory symbol,string memory baseURI)
        public
        ERC721(name, symbol)
    {
        _setBaseURI(baseURI);
    }

    function mint(string calldata name,string calldata tokenURI) external returns (uint256 tokenId) {
        Present memory p = Present({Name: name});
        presents.push(p);
        tokenId = presents.length - 1;
        
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId,tokenURI);
    }
}
