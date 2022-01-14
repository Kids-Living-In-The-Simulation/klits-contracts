import * as fs from "fs";
import { optimize } from "svgo";
import parts from "./klits_parts.json";
import KlitsContract from "./src/KlitsContract";

(async () => {
    for (let id = 0; id < 10000; id += 1) {

        /*let data = fs.readFileSync(`./klits_svg/kltsMate-${id}.svg`, "utf8").toString();
        data = data.replace(/ fill-opacity:1.000; stroke:none;/g, "");
        data = data.replace(/ width=\"1\"/g, ' width="1.05"');
        data = data.replace(/ height=\"1\"/g, ' height="1.05"');

        const result = optimize(data, { multipass: true });
        const optimizedSvgString = result.data.replace('width="25" height="25"', 'preserveAspectRatio="xMinYMin meet" viewBox="0 0 24 24"');*/

        const retry = async () => {
            try {
                //await KlitsContract.setImage(id, optimizedSvgString);
                await KlitsContract.setAttributes(id, JSON.stringify((parts as any)[id].attributes));
            } catch (e) {
                console.error(e);
                await retry();
            }
        };
        await retry();
        console.log(`#${id} Image Uploaded.`);
    }
})();
