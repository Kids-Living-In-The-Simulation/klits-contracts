import { BigNumberish } from "ethers";
import KlitsArtifact from "../artifacts/contracts/Klits.sol/Klits.json";
import Contract from "./Contract";
import Klaytn from "./Klaytn";

class KlitsContract extends Contract {

    constructor() {
        super("0x0a412f094C15010bbd413BE0fC07b8da26b0B05F", KlitsArtifact.abi);
    }

    public async setImage(tokenId: BigNumberish, image: string): Promise<void> {
        const register = Klaytn.walletAddress;
        await this.contract.methods.setImage(tokenId, image).send({ from: register, gas: 300000000 });
    }

    public async setAttributes(tokenId: BigNumberish, attributes: string): Promise<void> {
        const register = Klaytn.walletAddress;
        await this.contract.methods.setAttributes(tokenId, attributes).send({ from: register, gas: 300000000 });
    }
}

export default new KlitsContract();
