pragma solidity >=0.4.21 <0.6.0;

// TODO: define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
import "./ERC721MintableComplete.sol";



// DONE define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is ERC721MintableComplete {
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

}









