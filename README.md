# email-signatures
Contains the necessary data and code to generate the email signature of the needed employees in EHS.

## Components
### Secrets
The real data for the signatures are stored as GitHub secrets in the [EHS organization](https://github.com/Equipaments-Hosteleria-Salou).
Each secret belongs to the person with the same initial in its name. This is for privacy reasons. Secrets are used in 
the [GitHub Actions workflow](https://github.com/Equipaments-Hosteleria-Salou/email-signatures/actions).

To add a new signature you will need to define the secrets for the personal data of that employee in the 
[organization secrets](https://github.com/organizations/Equipaments-Hosteleria-Salou/settings/secrets/actions).

### Data files
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

### Template
The template for all the signatures is defined in the `template` folder. The template is valid for all signatures. No 
need to modify it to add a new signature. The template is written in HTML and uses the image stored in [this public 
repository](https://github.com/Equipaments-Hosteleria-Salou/simple-image-hosting) to obtain the images for the 
signature.

The template is designed to be used with [Handlebars](https://handlebarsjs.com/)

## Template render
To render the template you 

```shell
npm install handlebars
```

