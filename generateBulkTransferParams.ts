import SkyUtil from "skyutil";
import fs from "fs";

const tos: string[] = [];
const ids: number[] = [];

const start = 1750;
SkyUtil.repeat(250, (index) => {
    tos.push("0x8FFc61c21553D893BBA612F9895547B5B95A9AE1");
    ids.push(start + index);
});

fs.writeFileSync("./tos.json", JSON.stringify(tos));
fs.writeFileSync("./ids.json", JSON.stringify(ids));
