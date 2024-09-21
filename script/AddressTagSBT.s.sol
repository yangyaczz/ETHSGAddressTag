// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console, console2} from "forge-std/Script.sol";
import {AddressTagSBT} from "../src/AddressTagSBT.sol";

contract AddressTagSBTScript is Script {

    // deploy
    // AddressTagSBT public atSBT;
    // function run() public {
    //     uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    //     vm.startBroadcast(deployerPrivateKey);


    //     atSBT = new AddressTagSBT();

    //     uint256[] memory ids = new uint256[](4);
    //     ids[0] = 0;
    //     ids[1] = 1;
    //     ids[2] = 2;
    //     ids[3] = 3;

    //     bytes32[] memory bytes32s = new bytes32[](4);
    //     bytes32s[0] = keccak256("whale trader");
    //     bytes32s[1] = keccak256("malicious actor");
    //     bytes32s[2] = keccak256("arbitrage trader");
    //     bytes32s[3] = keccak256("nft collector");

    //     atSBT.addTagType(ids, bytes32s);

    //     vm.stopBroadcast();
    // }


    // run
    AddressTagSBT public atSBT = AddressTagSBT(0x2EC5CfDE6F37029aa8cc018ED71CF4Ef67C704AE);

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // console2.log(atSBT.balanceOf(0xA552c195A6eEC742B61042531fb92732F8A91D6b,0));

        atSBT.mintAddressTagSBT(0xAE2B5589a42e644F78b7AAc2A8D5566b31c05084,1);

        // uint256[] memory ids = new uint256[](4);
        // ids[0] = 0;
        // ids[1] = 1;
        // ids[2] = 2;
        // ids[3] = 3;

        // bytes32[] memory bytes32s = new bytes32[](4);
        // bytes32s[0] = keccak256("whale trader");
        // bytes32s[1] = keccak256("malicious actor");
        // bytes32s[2] = keccak256("arbitrage trader");
        // bytes32s[3] = keccak256("nft collector");
        // atSBT.addTagType(ids, bytes32s);

        vm.stopBroadcast();
    }



    // forge script script/AddressTagSBT.s.sol:AddressTagSBTScript --rpc-url https://network.ambrosus-test.io --legacy --broadcast

    // forge script script/AddressTagSBT.s.sol:AddressTagSBTScript --rpc-url https://network.ambrosus-test.io --legacy --broadcast -vvvv
}
