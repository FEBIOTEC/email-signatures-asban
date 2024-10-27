<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Top language][language-shield]][language-url]
[![Language count][language-count-shield]][language-count-url]
[![GNU GPL v3 License][license-shield]][license-url]
[![Lines of code][loc-shield]][loc-url]
[![Number of commits since v0.1][commit-shield]][commit-url]
[![Commit activity][activity-shield]][activity-url]
[![Repository size][repo-size-shield]][repo-size-url]
[![CD pipeline][CD-pipeline-shield]][CD-pipeline-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://febiotec.es">
    <img src=".github/images/febiotec.png" alt="Logo">
  </a>

<h6 align="center">presents</h3>

<img src=".github/images/logo.png" alt="Logo">
<h3 align="center">email-signatures-asban</h3> 

  <p align="center">
    Contains the necessary data and code to automate the generation of the email signatures from ASBAN email accounts.
    <br />
    <a href="#usage"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://youtu.be/v4Mi0DMAwQU">View Demo</a>
    ·
    <a href="https://github.com/FEBIOTEC/email-signatures-asban/issues/new">Report Bug</a>
    ·
    <a href="https://github.com/FEBIOTEC/email-signatures-asban/issues/new">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
      <ul>
        <li><a href="#How-to-add-a-new-signature">How to add a new signature</a></li>
        <li><a href="#How-to-update-a-signature">How to update a signature</a></li>
        <li><a href="#How-to-update-all-signatures">How to update all signatures</a></li>
      </ul>
    <li><a href="#Components">Components</a></li>
      <ul>
        <li><a href="#Bulk-update-of-secrets">Bulk update of secrets</a></li>
        <li><a href="#Secrets">Secrets</a></li>
        <li><a href="#How-to-update-all-signatures">How to update all signatures</a></li>
        <li><a href="#Data-files">Data files</a></li>
        <li><a href="#Template">Template</a></li>
        <li><a href="#Template-render">Template render</a></li>
        <li><a href="#Template-output">Template output</a></li>
        <li><a href="#Email-sending">Email sending</a></li>
        <li><a href="#Workflow">Workflow</a></li>
      </ul>
    <li><a href="#Roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
    <li><a href="#Credits">Credits</a></li>
      <ul>
        <li><a href="#Institutions-involved-in-the-email-signatures-project">Institutions involved in the email-signatures project</a></li>
        <li><a href="#People-involved-in-the-email-signatures-development">People involved in the email-signatures development</a></li>
      </ul>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://github.com/FEBIOTEC/email-signatures-asban/.github/images/product-screenshot.png)

This repository contains a mixture of scripts that are programmed to act in coordination in a workflow that is triggered
when the signature data files are modified. The modified data files are also used as a way to know which signatures need 
to be built and sent to the corresponding owners to those signatures. This means that this repository is a live 
repository and its execution will be usually done in GitHub servers that run the action.

To know more about FEBIOTEC, you can check the
[web page](https://febiotec.es).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

#### Built With

This section lists any major frameworks/libraries used to bootstrap the email-signatures platform:

* [![GIT][git-shield]][git-url]
* [![Bash][bash-shield]][bash-url]
* [![NodeJS][nodejs-shield]][nodejs-url]
* [![Handlebars][handlebars-shield]][handlebars-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

1. [Enable 2-Step Verification](https://support.google.com/accounts/answer/185839?hl=en&co=GENIE.Platform%3DAndroid) in
  the FEBIOTEC Gmail account that is going to be the automatic sender of emails. This is needed to create an App 
  password.
2. [Create an App password](https://support.google.com/accounts/answer/185833?hl=en) for `Mail`.
3. Add the email account and the code that you got from step 2 in the `secrets.txt` file or add the secrets into 
  [here](https://github.com/FEBIOTEC/email-signatures-asban/settings/secrets/actions). The name for the secrets is 
  `EMAIL_USERNAME` and `EMAIL_PASSWORD`. The first contains the email account that is going to be the automatic sender 
  of emails for the signatures and the second is the password that you got from step 2. 
4. Create the secrets
  `N_NAME`, `N_EMAIL`, `N_POSITION` and `N_LINKEDIN`, which are the name, the email, the position and a link to the 
  LinkedIn of the person, where `N` is an arbitrary string used by the program to *identify* (`N` needs to be unique) 
  a particular signature. We recommend `N` to be the name of the position that this signature is generated for, or an
  initial of the name of the person, but it can be anything as long as it is the *only* signature with that value of 
  `N`. You can create these secrets manually [by going to the GitHub secrets of this 
  repo](https://github.com/FEBIOTEC/email-signatures-asban/settings/secrets/actions), or you can use the `setSecrets.sh` 
  script in the `tools` folder. This tool will read the file `secrets/secrets.txt` expecting variables called the same 
  as the ones that we want to declare as secrets in **shell** format. You can find an example of `secrets.txt` in  
  `templates/secrets.txt` folder. Repeat this step for as many email accounts as you like.
5. Create the file `N.json` in the `data` folder. The content of this file is the same as the file 
  `templates/data.json`, but you need to change the name to `N.json`.
6. Add access to the secrets in the workflow declared at `.github/workflows/buildAndSendSignatures.yml` that you declared
   in the first step. There will be other secrets declared in the `secrets:` section of that file that you can use as
   example for your own secrets.
7. Add the files, commit and push to GitHub to trigger the workflow. You will receive in the email that you specified 
  for each signature its signature in html format.
8. Open the html file with your browser. You need to see the signature that you generated on the browser.
9. Select everything. We recommend using Ctrl+A in Windows or Command+A in Mac to select everything in the page. If it
  not works, look for the right action or key combination to select all text.
10. Copy all the content of the signature.
11. Return to the Gmail account that we are configuring. Click the gear in the top-right part of the screen and then 
  click **all settings**, look for **signature** and click on **Create New**. Write a name for your signature (anything 
  is valid)
12. Paste the content in the text box. You can also configure in which circumstances you want your signature to be used
  by selecting the signature that you just created from the dropdowns **FOR NEW EMAILS USE** and **ON REPLY/FORWARD 
  USE**. We recommend that you select the signature that you just created in both dropdowns.

With this, the repository and your signatures will be configured for each email account. 

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
<!-- Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos 
work well in this space. You may also link to more resources. -->

## Usage
You can do the following with
this repository:
- **Add new signatures:** By following the steps since step 4 because we do not need to generate a new token from the
  sender account.
- **Update signatures:** You can update signatures by modifying the corresponding `N.json` from the signatures that you
  want to update. The workflow will run again and the owner of the signature will receive its updated signature.
- **Regenerate (resend) signatures:** To resend a signature with the same content we need to change something in the
  corresponding `N.json` file. Since we need to change something from the file to trigger the workflow, but we actually
  need to send the same data, we can introduce "meaningless" changes in the file, such as adding or deleting blank lines
  at the end of the file by pressing enter in a text editor.
- **Delete signature:** You can delete the secrets in the repo and the `N.json` file of that signature. Remember that the
  secrets will be deleted for sure but the GitHub repo content will be available forever.
- **Modify the signature template:** You can modify the static elements of the signature by editing the HTML file in
  `templates/template.html`.
- **Add, delete, modify fields in the signature:** You will need to modify the contents of the array `marks` in the
  `src/substituteMarks.sh` with the fields that you want. Of course, you will need to also modify the secrets, the
  secrets access in the workflow and the data files with your new marks if there are any.
- **Customize a particular signature:** When the signature is received, modify the HTML as you like or modify the content
  of the signature using the editor provided in the Gmail account in the *signatures* section after you pasted the
  content into the editor. We recommend using the Gmail editor as you do not need to deal with HTML code and instead you
  have the generic editor of Gmail to modify your own signature at your will.

###### How to add a new signature
1. Create the secrets in [this repo](https://github.com/FEBIOTEC/email-signatures-asban) `N_NAME`, `N_EMAIL`, `N_PHONE`
   and `N_IPHONE`, which are the name, the email, the phone
   and the phone with international prefix without spaces, where N is the initial
   or
   another string that identifies the person but *without revealing any of its personal data*. You can do this step
   manually or you can use the  
   `setSecrets.sh` script in the `tools` folder. This tool will read the file `secrets/secrets.txt` expecting variables
   called the same as the ones that we want to declare in the secrets in shell format. You can find an example of
   `secrets.txt` in the `templates` folder.
2. Create the file `N.json` in the `data` folder.
3. Add access to the secrets in the workflow declared at `.github/workflows/buildAndSendSignatures.yml` that you declared
   in the first step. There will be other secrets declared in the `secrets:` section of that file that you can use as
   example for your own secrets.
4. Add the files, commit and push to GitHub to trigger the workflow.

###### How to update a signature
- Change the data files corresponding to the signatures that you want to update to trigger the build and send of the
  updated signature.

> [!TIP]
> Since the workflow is only triggered when the signature is
updated, you can add a meaningless change in the data file of the signature such as adding a whitespace or a line
break at the end of the file to trigger the workflow and receive the signatures in your email.

###### How to update all signatures
- Change the template to trigger the build and send of all signatures.

> [!TIP]
> Since the workflow is only triggered when the signature is
updated, you can add a meaningless change in the data file of the signature such as adding a whitespace or a line
break at the end of the file to trigger the workflow and receive the signatures in your email.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- Components -->
## Components
###### Bulk update of secrets
We use `gh` CLI utility to read from a secret file that creates all of our organization secrets in bulk.

###### Secrets
The real data for the signatures are stored as GitHub secrets in the [FEBIOTEC organization](https://github.com/FEBIOTEC).
Each secret belongs to the person with the same initial in its name. This is for privacy reasons. Secrets are used in
the [GitHub Actions workflow](https://github.com/FEBIOTEC/email-signatures-asban/actions).

To add a new signature you will need to define the secrets for the personal data of that account in the
[organization secrets](https://github.com/organizations/FEBIOTEC/settings/secrets/actions).

###### Data files
Data for signatures is defined in the `data` folder in JSON format. The data files are the files that are used by the
templating engines to expand the marks in the template for the signature.

The algorithm to substitute the marks in the data files in **dynamic**, so there is no need to change the code if adding
new signatures.

To execute the algorithm to substitute marks you will need to run:
```shell
./substituteMarks.sh
```

This script is **idempotent**, and **it does not rely on relative paths**. It uses environment variables as implicit
parameters.

###### Template
The template for all the signatures is defined in the `template` folder. The template is valid for all signatures. No
need to modify it to add a new signature. The template is written in HTML and uses the image stored in [this public
repository](https://github.com/FEBIOTEC/email-signatures-asban/tree/master/.github/images) to obtain the images for the
signature.

The template is designed to be used with [Handlebars](https://handlebarsjs.com/).

###### Template render
To render the template you need to execute the JavaScript file `renderSignatures.js` in the `src` folder of this
repository. You will need to install `npm` and `node`. This will vary in each operating system, but usually the best
way is to [download the pre-built binaries](https://nodejs.org/en/download/prebuilt-binaries) or install [using the
package manager](https://nodejs.org/en/download/package-manager).

After that you need to install handlebars directly:
```shell
npm install handlebars
```

... or using the `package.json`:
```shell
cd email-signatures && npm install
```

After that, to execute the script you can do:
```shell
node ./src/renderSignatures.js
```

The template renderer script is **dynamic**, which means that there is no need to change the code of the script to
render new signatures. The script produces a signatures for each file in the `data` folder.

###### Template output
The output of the program is in the `out` folder. This folder is ignored because it contains the personal data of each
signature.

###### Email sending
We are using the [action-send-email](https://github.com/dawidd6/action-send-mail) from [@dawidd6](https://github.com/dawidd6).
You will need to configure an email account to be able to send the emails. For a Gmail account you need to configure an
App password in you Google account. Here are the steps:

1. [Enable 2-Step Verification.](https://support.google.com/accounts/answer/185839?hl=en&co=GENIE.Platform%3DAndroid).
   This is needed to create an App password.
2. [Create an App password](https://support.google.com/accounts/answer/185833?hl=en) for `Mail`.

###### Workflow
All steps are triggered in a GitHub Actions Workflow:
- Secrets are read and injected as environment variables of the workflow.
- Environment variables are used to translate the marks into personal data of files in the `data` folder.
- Data files are used as input for the template to build the signatures.
- Signatures are sent to each respective owner.

There is a workflow for each managed signature that is triggered when that signature is modified.

If there is the need to add a new signature you need a workflow that manages that signature.



<!-- ROADMAP -->
## Roadmap
This project is completely functional! But there is still so much space for improvements...
- Refactor bash script, so it only translates the variables of the needed files.
- Refactor templating script, so it only creates the signature that is needed.
- A way to easily update and add signatures without the need to touching workflows, files, etc.
- Translate workflow to Python because it more maintainable than bash and because biotechnologists are probably more
  used to a language like Python.
- Another tool to automatically modify the workflow script when adding new signatures

See the [open issues](https://github.com/FEBIOTEC/email-signatures-asban/issues) for a full list of proposed features 
(and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing
This is an open-source project, so any contributions are **greatly appreciated** ❤. 

If you have an issue or suggestion that would make email signatures better, please
[open a new issue](https://github.com/FEBIOTEC/email-signatures-asban/issues/new) explaining your inquiry. We will try 
to satisfy your
needs as soon as possible.

If you want to make a contribution to email-signatures-asban by yourself, please
[open a new issue](https://github.com/FEBIOTEC/email-signatures-asban/issues/new), so we can discuss the reach of your 
contribution.
After that, [fork the repo](https://github.com/FEBIOTEC/email-signatures-asban/fork), implement your change and create a
[pull request](https://github.com/FEBIOTEC/email-signatures-asban/compare) from your fork to the `master` branch. We will merge 
your changes as soon as possible, so they are available in the next releases of email-signatures-asban.

So, for each change that you want to do to email-signatures-asban by yourself, you will need to:
1. [Fork the repo](https://github.com/FEBIOTEC/email-signatures-asban/fork).
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Add and commit your Changes (`git add src; git commit -am 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Repeat steps 3 and 4 as many times as you need.
6. [Open a pull request from your fork to the develop branch](https://github.com/FEBIOTEC/email-signatures-asban/compare).
7. Repeat steps 3 and 4 if further changes are required.

Do not forget to give the project a star ⭐ on GitHub!

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License
![APGLv3 logo](https://www.gnu.org/graphics/agplv3-with-text-162x68.png "GNU AFFERO GENERAL PUBLIC LICENSE, Version 3")

Distributed under the [GNU AFFERO GENERAL PUBLIC LICENSE, Version 3](https://www.gnu.org/licenses/agpl-3.0.en.html).
See [`LICENSE`](https://github.com/FEBIOTEC/email-signatures-asban/blob/master/LICENSE) to obtain a copy of the therms 
of this license.

This software was developed by [Aleix Mariné-Tena](https://github.com/AleixMT), the informatics responsible for ASBTEC
and member of the working unit of informatics in FEBIOTEC.

**email-signatures-asban ultimately belongs to [Aleix Mariné-Tena](https://github.com/AleixMT) and has the control over 
the licensing and distribution therms.**

>Copyright 2024-2024 [Aleix Mariné-Tena](https://github.com/AleixMT)

>This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public
License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
version.
>
>This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

>Aleix Mariné-Tena - [aleixmarine@febiotec.es 📫](aleixmarine@febiotec.es) [amarine@asbtec.cat 📫](amarine@asbtec.cat)

You can also reach us on Twitter [@FEBiotec](https://x.com/FEBiotec).

You can get more information of our work and research on our official web page https://febiotec.es.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments
Shout out to [@Bpazg97](https://github.com/Bpazg97) who suggested the usage of HandleBars which suited the job
perfectly.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Credits
#### Institutions involved in the email-signatures project
![Logo FEBIOTEC](.github/images/febiotec.png)
[Spanish Federation of Biotechnologists (FEBIOTEC)](https://febiotec.es/): FEBIOTEC, the mother association of the
regional association of biotechnologists. All the other biotechnologists associations that belong to 
the federation can benefit from the email-signatures project.

![Logo ASBTEC](.github/images/asbtec.jpg)
[Association of Biotechnologists of Catalonia(ASBTEC)](https://www.asbtec.cat): ASBTEC, the association of 
biotechnologists of catalonia, and the original association of the creator of this project, 
[Aleix Mariné-Tena](https://github.com/AleixMT).

![Logo ASBAN](.github/images/asban.png)
[Association of Biotechnologists of Aragón (ASBAN)](https://www.asbanagon.es): ASBAN, the association of
biotechnologists and the association that will benefit from this particular repository 
[email-signatures-asban](https://github.com/FEBIOTEC/email-signatures-asban).


#### People involved in the email-signatures development
* **Aleix Mariné-Tena (ASBTEC)**: Informatics responsible of ASBTEC. Main developer of *email-signatures*. 
* **Adrián Macias (ASBAN)**: President of ASBAN. Currently, we are collaborating to configure automations for our 
  associations, such as the one that is implemented in this repository.
* **David Alvárez (FEBIOTEC)**: Honorific president of FEBIOTEC and responsible for innovation. Coordinates things 
  related with email-signatures.



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[forks-shield]: https://img.shields.io/github/forks/FEBIOTEC/email-signatures-asban.svg?style=for-the-badge&label=Fork&maxAge=2592000
[forks-url]: https://github.com/FEBIOTEC/email-signatures-asban/network/members
[license-shield]: https://img.shields.io/github/license/FEBIOTEC/email-signatures-asban?style=flat-square&color=darkgreen&logo=gnu
[license-url]: https://github.com/FEBIOTEC/email-signatures-asban/blob/master/LICENSE
[product-screenshot]: .github/images/product-screenshot.png

[language-shield]: https://img.shields.io/github/languages/top/FEBIOTEC/email-signatures-asban?style=flat-square&color=yellow&logo=gnubash
[language-url]: https://www.gnu.org/software/bash/
[loc-shield]: https://img.shields.io/endpoint?url=https://ghloc.vercel.app/api/FEBIOTEC/email-signatures-asban/badge?filter=.html$,.sh$,.js$&style=flat&logoColor=white&label=Lines%20of%20Code
[loc-url]: https://github.com/FEBIOTEC/email-signatures-asban
[commit-shield]: https://img.shields.io/github/last-commit/FEBIOTEC/email-signatures-asban/master?style=flat-square&logo=github
[commit-url]: https://github.com/FEBIOTEC/email-signatures-asban/issues
[activity-shield]: https://img.shields.io/github/commit-activity/y/FEBIOTEC/email-signatures-asban?style=flat-square&color=black&logo=github
[activity-url]: https://github.com/FEBIOTEC/email-signatures-asban/graphs/commit-activity
[repo-size-shield]: https://img.shields.io/github/repo-size/FEBIOTEC/email-signatures-asban?style=flat-square&logo=github
[repo-size-url]: https://github.com/FEBIOTEC/email-signatures-asban
[language-count-shield]: https://img.shields.io/github/languages/count/FEBIOTEC/email-signatures-asban?style=flat-square&color=red&logo=github
[language-count-url]: https://github.com/FEBIOTEC/email-signatures-asban
[CD-pipeline-shield]: https://img.shields.io/github/actions/workflow/status/FEBIOTEC/email-signatures-asban/buildAndSendSignatures.yml?style=flat-square&logo=githubactions&label=last%20workflow%20execution
[CD-pipeline-url]: https://github.com/FEBIOTEC/email-signatures-asban/actions/workflows/buildAndSendSignatures.yml

[git-shield]: https://img.shields.io/badge/git-2.25.1-black?style=for-the-badge&logo=git
[git-url]: https://git.com
[bash-shield]: https://img.shields.io/badge/bash-5.0.17-black?style=for-the-badge&logo=gnubash
[bash-url]: https://www.gnu.org/software/bash/
[nodejs-shield]: https://img.shields.io/badge/nodejs-16.20.2-green?style=for-the-badge&logo=node.js
[nodejs-url]: https://nodejs.org/en
[handlebars-shield]: https://img.shields.io/badge/handlebarsjs-4.7.8-red?style=for-the-badge&logo=handlebarsjs
[handlebars-url]: https://handlebarsjs.com/