#!/usr/bin/env node
/*
email-signatures-asban is a live repository that contains the necessary data and code to automate the generation of
the email signatures from ASBAN email accounts.

Copyright (C) 2024 - present @ Aleix Mariné-Tena (github.com/AleixMT)

email-signatures-asban is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

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
