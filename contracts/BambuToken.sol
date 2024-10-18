// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BambuToken is ERC20, Ownable {
    uint256 public constant TOTAL_SUPPLY = 100_000_000 * 10**18;

    constructor() ERC20("Bambu", "Bbu") {
        _mint(msg.sender, TOTAL_SUPPLY);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function withdrawRemainingTokens() external onlyOwner {
        uint256 remainingTokens = balanceOf(address(this));
        _transfer(address(this), msg.sender, remainingTokens);
    }
}