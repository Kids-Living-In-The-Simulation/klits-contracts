pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./klaytn-contracts/ownership/Ownable.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/IMix.sol";

contract KlitsMinter is Ownable {
    using SafeMath for uint256;

    IKIP17Enumerable public nft;
    IMix public mix;
    uint256 public mintPrice;

    uint256 public limit;

    constructor(
        IKIP17Enumerable _nft,
        IMix _mix,
        uint256 _mintPrice
    ) public {
        nft = _nft;
        mix = _mix;
        mintPrice = _mintPrice;
    }

    function setLimit(uint256 _limit) external onlyOwner {
        limit = _limit;
    }

    function setMintPrice(uint256 _price) external onlyOwner {
        mintPrice = _price;
    }

    function mint(uint256 count) external {
        uint256 balance = nft.balanceOf(address(this));
        require(count <= balance);
        for (uint256 i = 0; i < count; i += 1) {
            nft.transferFrom(address(this), msg.sender, nft.tokenOfOwnerByIndex(address(this), i));
        }
        mix.transferFrom(msg.sender, address(this), mintPrice.mul(count));
        limit = limit.sub(count);
    }

    function withdrawMix() external onlyOwner {
        mix.transfer(msg.sender, mix.balanceOf(address(this)));
    }
}
