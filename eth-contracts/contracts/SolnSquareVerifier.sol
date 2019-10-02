pragma solidity >=0.4.21 <0.6.0;

// TODO: define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
import "./Verifier.sol";
import "./AwesomeTitle.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";



// DONE define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is AwesomeTitle, Verifier {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    string internal constant _baseTokenURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/";

    // DONE: define a solutions struct that can hold an index & an address
    struct Solution {
        bytes32 solutionHash;
        address someAddress;
    }

    // DONE: define an array of the above struct
    Solution[]  solutions;

    // DONE: define a mapping to store unique solutions submitted
    mapping(address => Solution[]) submittedSolutions;

    // DONE: Create an event to emit when a solution is added
    event SolutionSubmitted(address submittedBy);

    function solutionExists(bytes32 theHash, address theAddress)
    internal
    returns (bool)
    {
        if (submittedSolutions[theAddress].solutions.length == 0) {
            return false;
        } else { // address has submitted solutions, need to iterate over them.
            for(uint i = 0; i < submittedSolutions[theAddress].solutions.length; i++) {
                if(submittedSolutions[theAddress].solutions[i].solutionHash == theHash){
                    return true; // solution has already been submitted by this address.
                }
                return false; // this is a new solution.
            }
        }

    }

    // DONE Create a function to add the solutions to the array and emit the event
    function addSolution(uint[2] pa, uint[2][2] pb, uint[2] pc, uint[2] i, address to)
    external
    {
        bytes32 newHash = keccak256(abi.encodePacked(pa, pb, pc, i));
        require(solutionExists(newHash, to) == false, "Solution has already been submitted by this address");

        // Solution doesn't already exist, add to solutions for this address
        Solution memory newSolution;
        newSolution.solutionHash = newHash;
        newSolution.someAddress = to;
        submittedSolutions[to].solutions.push(newSolution);
        emit SolutionSubmitted(msg.sender);

        bool solutionIsValid = verifyTx(pa,pb,pc,i);
        require(solutionIsValid == true, "This solution is not valid");

        newTitle(to);
    }

    // DONE: Create a function to mint new NFT only after the solution has been verified
    //  - make sure the solution is unique (has not been used before)
    //  - make sure you handle metadata as well as tokenSuplly

    // Creates a new title for an owner of a property.
    function newTitle(address to)
    internal
    returns(bool)
    {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    string memory strTokenId = uint2str(newItemId);
    bool success = false;
    string memory tokenURI;
    tokenURI = strConcat(_baseTokenURI, strTokenId);

    bool isMinted = mint(to, newItemId, tokenURI);

    success = isMinted;

    return success;
    }
}









