const { SignProtocolClient, SpMode, EvmChains } = require("@ethsign/sp-sdk");
const { privateKeyToAccount } = require("viem/accounts");
const { createPublicClient, http, defineChain, decodeFunctionData } = require('viem')
const abifile = require("../out/AddressTagSBT.sol/AddressTagSBT.json")

require('dotenv').config();
const privateKey = process.env.PRIVATE_KEY

const client = new SignProtocolClient(SpMode.OnChain, {
    chain: EvmChains.baseSepolia,
    account: privateKeyToAccount(privateKey),
});


// async function createSchemademo() {
//     const res = await client.createSchema({
//         name: "Address Tag",
//         data: [
//             { name: "contractDetails", type: "string" },
//             { name: "signer", type: "address" },
//         ],
//     });
//     console.log(res)
// }
// createSchemademo()


async function createNotaryAttestation(contractDetails, signer) {
    const res = await client.createAttestation({
        schemaId: "0x2f1",
        data: {
            contractDetails,
            signer
        },
        indexingValue: signer.toLowerCase()
    });

    console.log('result:', res)
}

// createNotaryAttestation("dasdsaddddddd", '0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646')


const airTest = defineChain({
    id: 22040,
    rpcUrls: {
        default: {
            http: ['https://testnet-rpc.airdao.io/'],
        },
    }
});

const clientViem = createPublicClient({
    chain: airTest,
    transport: http()
});


const contractAddress = '0x2EC5CfDE6F37029aa8cc018ED71CF4Ef67C704AE';
const abi = abifile.abi;

let lastBlockNumber = null;


setInterval(async () => {
    try {
        const latestBlock = await clientViem.getBlock({ blockTag: 'latest' });
        const latestBlockNumber = latestBlock.number;

        if (lastBlockNumber === null) {
            lastBlockNumber = latestBlockNumber;
            return;
        }

        if (latestBlockNumber === lastBlockNumber) {
            console.log('no block');
            return;
        }

        console.log(`from ${lastBlockNumber + 1n} to ${latestBlockNumber} txs`);

        for (let blockNumber = lastBlockNumber + 1n; blockNumber <= latestBlockNumber; blockNumber++) {
            const blockWithTransactions = await clientViem.getBlock({
                blockNumber: blockNumber,
            });

            const transactionPromises = blockWithTransactions.transactions.map((txHash) =>
                clientViem.getTransaction({ hash: txHash })
            );

            const transactions = await Promise.all(transactionPromises);

            const contractTransactions = transactions.filter(
                (tx) => tx.to && tx.to.toLowerCase() === contractAddress.toLowerCase()
            );


            if (contractTransactions.length > 0) {
                console.log('~~~~~~~~~~~~~~~')
                console.log(`block ${blockNumber} tx bumber ${contractTransactions.length}`);

                // decode
                contractTransactions.forEach((tx) => {
                    const decodedData = decodeFunctionData({
                        abi: abi,
                        data: tx.input,
                    });
                    console.log(`deocde data:`, decodedData);

                    createNotaryAttestation(decodedData.args[1].toString(), decodedData.args[0])
                });

                console.log('~~~~~~~~~~~~~~~')
            } else {
                console.log(`block ${blockNumber} have no tx`);
            }
        }

        // update block number
        lastBlockNumber = latestBlockNumber;

    } catch (error) {
        console.error('query block error: ', error);
    }
}, 20000);