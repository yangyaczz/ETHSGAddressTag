const { SignProtocolClient, SpMode, EvmChains } = require("@ethsign/sp-sdk");
const { privateKeyToAccount } = require("viem/accounts");

const privateKey = '0x7827f7be03b7bad2ad8d4639d68c261639c92bdd44ceb0926bc0f335984f9606';

const client = new SignProtocolClient(SpMode.OnChain, {
    chain: EvmChains.baseSepolia,
    account: privateKeyToAccount(privateKey), // Optional, depending on environment
});


// async function createSchemademo() {
//     const res = await client.createSchema({
//         name: "SDK Test",
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

createNotaryAttestation("dasdsaddddddd", '0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646')