# Udacity Blockchain Capstone

The capstone will build upon the knowledge you have gained in the course in order to build a decentralized housing product.

# Project Resources

* [Remix - Solidity IDE](https://remix.ethereum.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Truffle Framework](https://truffleframework.com/)
* [Ganache - One Click Blockchain](https://truffleframework.com/ganache)
* [Open Zeppelin ](https://openzeppelin.org/)
* [Interactive zero knowledge 3-colorability demonstration](http://web.mit.edu/~ezyang/Public/graph/svg.html)
* [Docker](https://docs.docker.com/install/)
* [ZoKrates](https://github.com/Zokrates/ZoKrates)


### https://zokrates.github.io/print.html

So, having defined the program, Victor is now ready to compile the code:


`./zokrates compile -i hashexample.code`
Based on that Victor can run the setup phase and export verifier smart contract as a Solidity file:

```bash

./zokrates setup
./zokrates export-verifier

```
setup creates a verifiation.key file and a proving.key file. Victor gives the proving key to Peggy.

export-verifier creates a verifier.sol contract that contains our verification key and a function verifyTx. Victor deploys this smart contract to the Ethereum network.

Peggy provides the correct pre-image as an argument to the program.


`./zokrates compute-witness -a 0 0 0 5`
Finally, Peggy can run the command to construct the proof:


`./zokrates generate-proof`
As the inputs were declared as private in the program, they do not appear in the proof thanks to the zero knowledge property of the protocol.

ZoKrates creates a file, proof.json, consisting of the three elliptic curve points that make up the zkSNARKs proof. The verifyTx function in the smart contract deployed by Victor accepts these three values, along with an array of public inputs. The array of public inputs consists of:

any public inputs to the main function, declared without the private keyword
the return values of the ZoKrates function
In the example we're considering, all inputs are private and there is a single return value of 1, hence Peggy has to define her public input array as follows: [1]

Peggy can then submit her proof by calling verifyTx.

Victor monitors the verification smart contract for the Verified event, which is emitted upon successful verification of a transaction. As soon as he observes the event triggered by a transaction from Peggy's public address, he can be sure that Peggy has a valid pre-image for the hash he set in the smart contract.
