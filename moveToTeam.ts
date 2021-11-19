import SkyUtil from "skyutil";
import fs from "fs";

const tos: string[] = [];
const ids: number[] = [];

const start = 750;
SkyUtil.repeat(250, (index) => {
    tos.push("0xC7728202e5c57B0A8C52f496Dc72Eda7C70677e5");
    ids.push(start + index);
});

fs.writeFileSync("./tos.json", JSON.stringify(tos));
fs.writeFileSync("./ids.json", JSON.stringify(ids));
