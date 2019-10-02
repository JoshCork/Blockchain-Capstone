var AwesomeTitle = artifacts.require('AwesomeTitle');

contract('TestERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];
    const tokenId_1 = 1;
    const tokenId_2 = 2;
    const tokenBaseURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/"

    describe('match erc721 spec', function () {
        beforeEach(async function () {
            this.contract = await AwesomeTitle.new({from: account_one});
            // TODO: mint multiple tokens
            this.contract.mint(account_one, tokenId_1, tokenBaseURI + tokenId_1.toString());
            this.contract.mint(account_two, tokenId_2, tokenBaseURI + tokenId_2.toString());
        })

        it('should return total supply', async function () {
            var totalSupply = await this.contract.totalSupply();
            assert.equal(totalSupply, 2, "Unexpected Total Supply");

        })

        it('should get token balance', async function () {
            var ownerOneBalance = await this.contract.balanceOf(account_one);
            assert.equal(ownerOneBalance, 1, "Unexpected Balance for Owner One");

        })

        it('should return token uri', async function () {
            console.log(`IS THIS RIGHT?: ${tokenBaseURI + tokenId_1.toString()}`)
            let expectedURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1"
            let actualURI = await this.contract.tokenURI(tokenId_1);
            assert.equal(expectedURI, actualURI, "Unexpected URI for token:1");
        })

        it('should transfer token from one owner to another', async function () {

        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () {
            this.contract = await AwesomeTitle.new({from: account_one});
        })

        it('should fail when minting when address is not contract owner', async function () {

        })

        it('should return contract owner', async function () {

        })

    });
})