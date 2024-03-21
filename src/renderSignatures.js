#!/usr/bin/env node

// Handlebars for templating
const Handlebars = require("handlebars");
// FS to access file system from local NPM context
const fs= require("fs");
// To obtain the name of the file without extension
const path = require('path');


let dirPath;
if (process.env.GH_ACTIONS_ENV) {
    dirPath = "./"
}
else {
    dirPath = "../"
}

function buildSignature(template, name)
{
    let data = fs.readFileSync(dirPath + "data/" + name + ".json", "utf8");
    let signature = template(JSON.parse(data));
    fs.writeFileSync(dirPath + "out/" + name + ".html", signature, {encoding: "utf8", flag: "w+", mode: 0o666 });
}

// Read text template and compile it
let templateText = fs.readFileSync(dirPath + "templates/template.html", "utf8");
const template = Handlebars.compile(templateText);

// Count signatures and get the name without extension
let filenames = Array.from(fs.readdirSync(dirPath + "data/")).map(filename => {
    let parsed = path.parse(filename);
    return parsed.name;
});

// Build signatures
for (let i = 0; i < filenames.length; i++)
{
    buildSignature(template, filenames.at(i));
}
