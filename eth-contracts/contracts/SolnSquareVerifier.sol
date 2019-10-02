pragma solidity >=0.4.21 <0.6.0;

// TODO: define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
import "./AwesomeTitle.sol";



// DONE define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is AwesomeTitle {
    // DONE: define a solutions struct that can hold an index & an address
    struct Solution {
        uint256 index;
        address someAddress;
    }

    // DONE: define an array of the above struct
    Solution[]  solutions;

    // DONE: define a mapping to store unique solutions submitted
    mapping(address => Solution[]) submittedSolutions;

    // DONE: Create an event to emit when a solution is added
    event SolutionSubmitted(address submittedBy);

    // DONE Create a function to add the solutions to the array and emit the event
    function addSolution(uint56 theIndex, address theAddress)
    external
    {
        Solution memory newSolution;
        newSolution.index = theIndex;
        newSolution.someAddress = theAddress;

        solutions.push(newSolution);
        submittedSolutions[msg.sender] = solutions; //probably not correct... or at least it seems weird because solutions will have all solutions
        emit SolutionSubmitted(msg.sender);
    }

    // TODO: Create a function to mint new NFT only after the solution has been verified
//  - make sure the solution is unique (has not been used before)
//  - make sure you handle metadata as well as tokenSuplly


//  using Counters for Counters.Counter;

//   Counters.Counter private _tokenIds;
//   string internal constant _baseTokenURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/";

//   constructor() ERC721Full("AwesomeTitle", "DEED") public {
//   }

//   // Creates a new title for an owner of a property.
//   function mint(address to, uint256 tokenId, string memory tokenURI)
//   public
//   onlyOwner
//   returns(bool)
//   {
//     _tokenIds.increment();
//     uint256 newItemId = _tokenIds.current();
//     string memory strTokenId = uint2str(newItemId);
//     bool success = false;
//     string memory tokenURI;

//     _mint(to, newItemId);
//     tokenURI = strConcat(_baseTokenURI, strTokenId);
//     _setTokenURI(tokenId,tokenURI);
//     success = true;

//     return success;
//   }

}









