// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract Source1155 is ERC1155, Ownable, Pausable, ERC1155Burnable, ERC1155Supply {
    //    constructor() ERC1155("https://velhalla-game.s3.amazonaws.com/MetaData/Item/UnitCardVoucher/NotRedeemed/UnitCardVoucher_001_No{id}.json") {}
    constructor() ERC1155("https://velhalla-game.s3.amazonaws.com/MetaData/Item/UnitCardVoucher/NotRedeemed/UnitCardVoucher_002_No{id}.json") {}

    string public name = "SourceNFT";
    string public constant symbol = "SNFT";


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address account, uint256 id, uint256 amount) public {
        _mint(account, id, amount, "");
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts) public {
        _mintBatch(to, ids, amounts, "");
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
    internal
    whenNotPaused
    override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function walletOfOwner(address _owner) public view returns (uint256[] memory) {
        uint256 ownerTokenCount = 20;
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i ; i < ownerTokenCount; i++) {
            tokenIds[i] = balanceOf(_owner, i);
        }
        return tokenIds;
    }
}
