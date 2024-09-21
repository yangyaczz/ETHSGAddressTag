## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```


cast call 0x2EC5CfDE6F37029aa8cc018ED71CF4Ef67C704AE --rpc-url https://network.ambrosus-test.io "balanceOf(address,uint256)(uint256)" 0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646 0 

cast call 0x2EC5CfDE6F37029aa8cc018ED71CF4Ef67C704AE --rpc-url https://network.ambrosus-test.io "balanceOf(address,uint256)(uint256)" 0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646 0x0

cast call 0x2EC5CfDE6F37029aa8cc018ED71CF4Ef67C704AE --rpc-url https://network.ambrosus-test.io "isApprovedForAll(address,address)(bool)" 0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646 0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646