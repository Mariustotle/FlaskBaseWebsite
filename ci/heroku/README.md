# Updating Certificate

## Prepare Environment
1. Install [Heroku Win64 CLI](https://devcenter.heroku.com/articles/heroku-cli#install-the-heroku-cli)
2. Install [Open SSL](https://slproweb.com/products/Win32OpenSSL.html)
3. Add OpenSSL Bin folder to the *System Path* variable e.g. "C:\Program Files\OpenSSL-Win64\Bin"

## Process
1. Get a new cert (Certifytheweb / ACME) into cert store
2. Download the cert PFX file locally
   .\Step2_UpdateCertificateFromCertStore.ps1 -certName "{Certificate name}" -certPassword "{Enter Password Here}"
3. Push the certificate to Heroku
   .\UpdateHeroku.ps1
