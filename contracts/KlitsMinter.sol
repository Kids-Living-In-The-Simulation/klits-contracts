pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./klaytn-contracts/ownership/Ownable.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/IMix.sol";

contract KlitsMinter is Ownable {
    using SafeMath for uint256;

    IKIP17Enumerable public nft = IKIP17Enumerable(0x0a412f094C15010bbd413BE0fC07b8da26b0B05F);
    IMix public mix = IMix(0xDd483a970a7A7FeF2B223C3510fAc852799a88BF);
    uint256 public mintPrice = 15 * 1e18;

    function setMintPrice(uint256 _price) external onlyOwner {
        mintPrice = _price;
    }

    uint256 public limit;

    function setLimit(uint256 _limit) external onlyOwner {
        limit = _limit;
    }

    function remains() external view returns (uint256) {
        uint256 balance = nft.balanceOf(address(this));
        return limit < balance ? limit : balance;
    }

    function mint(uint256 count) external {
        uint256 balance = nft.balanceOf(address(this));
        require(count <= balance);
        for (uint256 i = 0; i < count; i += 1) {
            nft.transferFrom(address(this), msg.sender, nft.tokenOfOwnerByIndex(address(this), i));
        }
        uint256 price = mintPrice.mul(count);
        // 35% to burn
        uint256 burn = price.mul(35).div(100);
        mix.burnFrom(msg.sender, burn);
        mix.transferFrom(msg.sender, 0xC7728202e5c57B0A8C52f496Dc72Eda7C70677e5, price.sub(burn));
        limit = limit.sub(count);
    }
}
