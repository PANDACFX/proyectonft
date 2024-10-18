// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract PandaNFT is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 public constant NFT_PRICE = 20 * 10**18;
    uint256 public constant MAX_SUPPLY = 5000;
    uint256 public constant TOTAL_AIRDROP_TOKENS = 60_000_000 * 10**18;

    IERC20 public BambuToken;
    uint256 public remainingAirdropTokens = TOTAL_AIRDROP_TOKENS;
    mapping(uint256 => uint256) public claimedTokens;

    event NFTMinted(address indexed to, uint256 tokenId, uint256 amount);
    event TokensClaimed(address indexed to, uint256 tokenId, uint256 amount);

    constructor(address _bambuToken)
        ERC1155("https://tan-necessary-wolverine-501.mypinata.cloud/ipfs/QmfPBcQRqtkL7Xxc679MitRUa9UqijaBT98bGTJ6z4Nucu")
        Ownable()
    {
        BambuToken = IERC20(_bambuToken);
    }

    function mint(uint256 amount) public payable {
        require(msg.value == NFT_PRICE * amount, "Ether value sent is not correct");
        require(_tokenIdCounter.current() + amount <= MAX_SUPPLY, "Maximum NFT limit reached");

        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            _mint(msg.sender, tokenId, 1, "");
            emit NFTMinted(msg.sender, tokenId, 1);
        }
    }

    function claimTokens(uint256 tokenId) public {
        require(balanceOf(msg.sender, tokenId) > 0, "You do not own this NFT");
        require(claimedTokens[tokenId] == 0, "Tokens already claimed for this NFT");

        uint256 tokensToClaim = calculateAirdropTokens(tokenId);

        remainingAirdropTokens -= tokensToClaim;
        claimedTokens[tokenId] = tokensToClaim;

        require(BambuToken.transfer(msg.sender, tokensToClaim), "Token transfer failed");

        emit TokensClaimed(msg.sender, tokenId, tokensToClaim);
    }

    function calculateAirdropTokens(uint256 tokenId) public view returns (uint256) {
        uint256 nftIndex = tokenId + 1;
        // Fórmula para la distribución decreciente
        uint256 tokens = (MAX_SUPPLY * 2 - nftIndex + 1) * remainingAirdropTokens / (MAX_SUPPLY * (MAX_SUPPLY + 1));
        return tokens;
    }

    function withdrawCFX() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function uri(uint256) public pure override returns (string memory) {
        return "https://tan-necessary-wolverine-501.mypinata.cloud/ipfs/QmfPBcQRqtkL7Xxc679MitRUa9UqijaBT98bGTJ6z4Nucu";
    }
}