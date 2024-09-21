// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AddressTagSBT is ERC1155, ReentrancyGuard, Ownable {
    mapping(address => mapping(address => mapping(uint256 => bool))) public isTagged;
    mapping(address => mapping(address => mapping(uint256 => bool))) public isRevoked;

    mapping(uint256 => bytes32) public idToTagType;

    constructor() ERC1155("AddressTag") {}

    //////========= ownable
    function addTagType(uint256[] memory ids, bytes32[] memory tagTypes) external onlyOwner {
        for (uint256 i = 0; i < ids.length; i++) {
            idToTagType[ids[i]] = tagTypes[i];
        }
    }

    //////========= user mint and burn SBT
    function mintAddressTagSBT(address target, uint256 id) external nonReentrant {
        // prevent attack
        // require(Address.isContract(msg.sender));
        require(!isTagged[msg.sender][target][id], "already tagged");
        require(idToTagType[id] != 0, "not tag type init yet");
        _mint(target, id, 1, "");

        isTagged[msg.sender][target][id] = true;
    }

    function revokeAddressTagSBT(address target, uint256 id) external nonReentrant {
        require(isTagged[msg.sender][target][id], "not tagged yet");

        require(!isRevoked[msg.sender][target][id], "already revoked");

        _burn(target, id, 1);

        isRevoked[msg.sender][target][id] = true;
    }

    //////=========  override
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        require(from == address(0) || to == address(0), "SBT cant transfer");
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
