/*  
███╗░░██╗███████╗████████╗██████╗░██████╗░███████╗██╗░░░██╗
████╗░██║██╔════╝╚══██╔══╝╚════██╗██╔══██╗██╔════╝██║░░░██║
██╔██╗██║█████╗░░░░░██║░░░░░███╔═╝██║░░██║█████╗░░╚██╗░██╔╝
██║╚████║██╔══╝░░░░░██║░░░██╔══╝░░██║░░██║██╔══╝░░░╚████╔╝░
██║░╚███║███████╗░░░██║░░░███████╗██████╔╝███████╗░░╚██╔╝░░
╚═╝░░╚══╝╚══════╝░░░╚═╝░░░╚══════╝╚═════╝░╚══════╝░░░╚═╝░░░
                                                              
Update values accordingly
*/

/*
Private Key Encryption
Replace ethraw with your private key "0xPRIVATEKEY" (Ethereum and other EVM)
Replace hhraw with your private key "0xPRIVATEKEY" (Hardhat)
*/

import SimpleCrypto from "simple-crypto-js"
const cipherKey = "#ffg3$dvcv4rtkljjkh38dfkhhjgt"
const ethraw = "1638f4a3360e9b7453e7dca7fa0d7126ae0044b5aa4a915e40b804c0baa4b0c1";
export const simpleCrypto = new SimpleCrypto(cipherKey)
export const cipherEth = simpleCrypto.encrypt(ethraw)
/*
Add the wallet address used to deploy the contracts below:
*/
export var bridgeWallet = "0xB038f80c7f8B290F1b5642CFDB5599D568f9A0A9";

/*
Global Configurations
*/

/*
Polygon Mumbai Testnet
*/
export var mumErc20 = "0x9ab834C78a00109f9c2e2be7C94AB70ae7f940B9";
export var mumCustody = "0xA77cDb8cD559EaD06d7Dd16988F3905296A9B9f6";
export var mumNFT = "0xb1E17e62B0D3ad46d52A3ff6f53BbE2A7068795E";
export var mumrpc = "https://matic-mumbai.chainstacklabs.com";

/*
Ethereum Goerli Testnet
*/
export var goeErc20 = "";
export var goeCustody = "";
export var goeNFT = "";
export var goerpc = "https://rpc.ankr.com/eth_goerli";

/*
BSC Testnet
*/
export var bsctErc20 = "0x9ab834C78a00109f9c2e2be7C94AB70ae7f940B9";
export var bsctCustody = "0xA77cDb8cD559EaD06d7Dd16988F3905296A9B9f6";
export var bsctNFT = "0xb1E17e62B0D3ad46d52A3ff6f53BbE2A7068795E";
export var bsctrpc = "https://data-seed-prebsc-1-s1.binance.org:8545/";

/*
Ethereum Mainnet
*/
export var ethrpc = "https://rpc.ankr.com/eth";

/*
BSC Mainnet
*/

export var bscrpc = "https://bsc-dataseed.binance.org";
