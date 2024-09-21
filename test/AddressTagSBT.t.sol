// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console, console2} from "forge-std/Test.sol";
import {AddressTagSBT} from "../src/AddressTagSBT.sol";

contract AddressTagSBTTest is Test {
    AddressTagSBT public atSBT;

    address alice = 0xBEbAF2a9ad714fEb9Dd151d81Dd6d61Ae0535646;
    address bob = 0x21C8e614CD5c37765411066D2ec09912020c846F;

    function setUp() public {
        vm.startPrank(alice);
        atSBT = new AddressTagSBT();
        vm.stopPrank();
    }

    function test_addTagType() public {
        vm.startPrank(alice);

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

        console2.logBytes32(atSBT.idToTagType(0));

        atSBT.addTagType(ids, bytes32s);

        console2.logBytes32(atSBT.idToTagType(0));
        vm.stopPrank();
    }

    function test_mint() public {
        test_addTagType();
        vm.startPrank(alice);

        atSBT.mintAddressTagSBT(bob, 0);
        atSBT.mintAddressTagSBT(bob, 1);

        vm.stopPrank();
    }

    function test_revoke() public {
        test_mint();
        vm.startPrank(alice);

        atSBT.revokeAddressTagSBT(bob, 0);
        atSBT.revokeAddressTagSBT(bob, 1);

        vm.stopPrank();
    }

    function testFail_transfer() public {
        test_mint();

        vm.startPrank(bob);
        atSBT.safeTransferFrom(bob, alice, 0, 1, "");
    }
} // forge test --match-path test/AddressTagSBT.t.sol -vvv
