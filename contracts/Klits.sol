pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/KIP17Full.sol";
import "./klaytn-contracts/token/KIP17/KIP17Mintable.sol";
import "./klaytn-contracts/token/KIP17/KIP17Pausable.sol";
import "./klaytn-contracts/ownership/Ownable.sol";
import "./libraries/EncodeLibrary.sol";

contract Klits is Ownable, KIP17Full("KLITS - Kids Living In The Simulation", "KIDS"), KIP17Mintable, KIP17Pausable {

    string public basename = "KLITS #";
    function setBasename(string calldata _basename) onlyOwner external {
        basename = _basename;
    }

    string public description = "Klits is a fully on-chain, generative NFT. No IPFS. No API. Just code.";
    function setDescription(string calldata _description) onlyOwner external {
        description = _description;
    }

    string public externalURL = "https://klits.xyz/";
    function setExternalURL(string calldata _externalURL) onlyOwner external {
        externalURL = _externalURL;
    }

    mapping(uint256 => string) public images;
    function setImage(uint256 tokenId, string calldata dataURL) onlyOwner external {
        images[tokenId] = dataURL;
    }

    mapping(uint256 => string) public attributes;
    function setAttributes(uint256 tokenId, string calldata _attributes) onlyOwner external {
        attributes[tokenId] = _attributes;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                EncodeLibrary.encode(
                    bytes(
                        string(
                            abi.encodePacked(
                                '{"name": "', 
                                basename,
                                EncodeLibrary.toString(tokenId),
                                '", "description": "',
                                description,
                                '", "external_url": "',
                                externalURL,
                                '", "image": "data:image/svg+xml;base64,',
                                EncodeLibrary.encode(
                                    bytes(images[tokenId])
                                ),
                                '","attributes":',
                                attributes[tokenId],
                                "}"
                            )
                        )
                    )
                )
            )
        );
    }

    function massMint(uint256 start, uint256 end) external onlyMinter {
        for (uint256 i = start; i <= end; i += 1) {
            mint(msg.sender, i);
        }
    }

    function bulkTransfer(address[] calldata tos, uint256[] calldata ids) external {
        uint256 length = ids.length;
        for (uint256 i = 0; i < length; i += 1) {
            transferFrom(msg.sender, tos[i], ids[i]);
        }
    }
}
