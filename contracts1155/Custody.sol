// SPDX-License-Identifier: MIT LICENSE



pragma solidity 0.8.18;

//import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
//import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// contract bridgeCustody is IERC721Receiver, ReentrancyGuard, Ownable {
contract Custody is IERC1155Receiver, ReentrancyGuard, Ownable {

  uint256 public costCustom = 1 ether;
  uint256 public costNative = 0.0000075 ether;

  struct Custody {
    uint256 [] tokenId;
    uint256 [] amounts;
  }

  mapping(address => Custody) holdCustody;

  event NFTCustody (
    uint256 [] indexed tokenId,
    uint256 [] indexed amounts,
    address holder
  );


  //ERC721Enumerable nft;
  IERC1155 public nft;
  IERC20 public paytoken;

   constructor(IERC1155 _nft, IERC20 _paytoken) {
    nft = _nft;
    paytoken = _paytoken;
  }

  //function retainNFTC(uint256 tokenId) public payable nonReentrant {
  function retainNFTC(uint256[] memory tokenIds, uint256[] memory amounts) public nonReentrant {
      require(tokenIds.length == amounts.length, "ERC1155: ids and amounts length mismatch");
      paytoken.transferFrom(msg.sender, address(this), costCustom);
      holdCustody[msg.sender] =  Custody(tokenIds, amounts);
      nft.safeBatchTransferFrom(msg.sender, address(this), tokenIds, amounts, "");
      emit NFTCustody(tokenIds, amounts, msg.sender);
  }

  function retainNFTN(uint256[] memory tokenIds, uint256[] memory amounts) public payable nonReentrant {
      require(msg.value == costNative, "Not enough balance to complete transaction.");
      require(tokenIds.length == amounts.length, "ERC1155: ids and amounts length mismatch");
      holdCustody[msg.sender] =  Custody(tokenIds, amounts);
      nft.safeBatchTransferFrom(msg.sender, address(this), tokenIds, amounts, "");
      emit NFTCustody(tokenIds, amounts, msg.sender);
  }



 
 function releaseNFT(uint256[] memory tokenIds, uint256[] memory amounts, address wallet) public nonReentrant onlyOwner() {
      
      nft.safeBatchTransferFrom(address(this), wallet, tokenIds, amounts, "");
      delete holdCustody[wallet];
 }

  function emergencyDelete(address user) public nonReentrant onlyOwner() {
      delete holdCustody[user];
 }

  // function onERC721Received(
  //       address,
  //       address from,
  //       uint256,
  //       bytes calldata
  //   ) external pure override returns (bytes4) {
  function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external pure override returns (bytes4) {
      //require(from == address(0x0), "Cannot Receive NFTs Directly");
      // return IERC721Receiver.onERC721Received.selector;
      return IERC1155Receiver.onERC1155Received.selector;
  }
  function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external pure override returns (bytes4) {
      //require(from == address(0x0), "Cannot Receive NFTs Directly");
      return IERC1155Receiver.onERC1155BatchReceived.selector;
    }

  function supportsInterface(bytes4 interfaceID) external view returns (bool) {
    return  interfaceID == 0x01ffc9a7 ||    // ERC-165 support (i.e. `bytes4(keccak256('supportsInterface(bytes4)'))`).
            interfaceID == 0x4e2312e0;      // ERC-1155 `ERC1155TokenReceiver` support (i.e. `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)")) ^ bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`).
  }

  function withdrawCustom() public payable onlyOwner() {
    paytoken.transfer(msg.sender, paytoken.balanceOf(address(this)));
    }

  function withdrawNative() public payable onlyOwner() {
    require(payable(msg.sender).send(address(this).balance));
    }
  
}