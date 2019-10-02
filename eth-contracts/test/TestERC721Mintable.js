var AwesomeTitle = artifacts.require('AwesomeTitle');

contract('TestERC721Mintable', accounts => {

    const account_one   = accounts[0];
    const account_two   = accounts[1];
    const account_three = accounts[3];
    const tokenId_1 = 1;
    const tokenId_2 = 2;
    const tokenId_3 = 3;
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
            let expectedURI = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1"
            let actualURI = await this.contract.tokenURI(tokenId_1);
            assert.equal(expectedURI, actualURI, "Unexpected URI for token:1");
        })

        it('should transfer token from one owner to another', async function () {

            try { // register once there are enough votes
                await this.contract.safeTransferFrom(account_one, account_three, tokenId_1);
            }
            catch(e) {
                console.log(e)
            }
            var actualBalance = await this.contract.balanceOf(account_three);
            var actualOwner = await this.contract.ownerOf(tokenId_1);
            let expectedOwner = account_three;
            assert.equal(actualBalance, 1, "Unexpected Balance for Owner One");
            assert.equal(expectedOwner, actualOwner, "Unexpected owner of token one");

        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () {
            this.contract = await AwesomeTitle.new({from: account_three});
        })

        it('should fail when minting when address is not contract owner', async function () {
            let theURI = tokenBaseURI + tokenId_3.toString()
            try { // register once there are enough votes
                await this.contract.mint(account_three, tokenId_3,theURI);
            }
            catch(e) {
                // console.log(e) // uncomment for troubleshooting.  This is expected to thow an error.  Specifically: 'Ownable: caller is not the owner'
            }
            let actualBalance = await this.contract.balanceOf(account_three);
            assert.equal(actualBalance, 0, "Unexpected Balance for Owner Three");

        })

        it('should return contract owner', async function () {
            let theOwner = await this.contract.owner();
            assert.equal(theOwner, account_three, "Unexpected Balance for Owner Three");
        })

    });
})