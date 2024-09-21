// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {AddressTagSBT} from "../src/AddressTagSBT.sol";

contract AddressTagSBTScript is Script {
    AddressTagSBT public atSBT;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);


        atSBT = new AddressTagSBT();

        uint256[] memory ids = new uint256[](4);
        ids[0] = 0;
        ids[1] = 1;
        ids[2] = 2;
        ids[3] = 3;

        bytes32[] memory bytes32s = new bytes32[](4);
        bytes32s[0] = keccak256("whale trader");
        bytes32s[1] = keccak256("malicious actor");
        bytes32s[2] = keccak256("arbitrage trader");
        bytes32s[3] = keccak256("nft collector");

        atSBT.addTagType(ids, bytes32s);

        vm.stopBroadcast();
    }

    // forge script script/AddressTagSBT.s.sol:AddressTagSBTScript --rpc-url https://network.ambrosus-test.io --legacy --broadcast
}
