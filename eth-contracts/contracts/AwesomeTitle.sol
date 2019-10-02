pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/lifecycle/Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Mintable.sol";
import "./Oraclize.sol";


contract AwesomeTitle is Pausable, ERC721Full, ERC721Mintable, Ownable, usingOraclize {

  string internal constant _baseTokenURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/";

  constructor() ERC721Full("AwesomeTitle", "DEED") public {
  }

  // Creates a new title for an owner of a property.
  function mint(address to, uint256 tokenId, string memory tokenURI)
  public
  onlyOwner
  returns(bool)
  {
    bool success = false;

    _mint(to, tokenId);
    _setTokenURI(tokenId,tokenURI);
    success = true;

    return success;
  }
}