param(
    [Parameter(Mandatory=$true)]
    [string]$certName,
    [Parameter(Mandatory=$true)]
    [string]$herokuAppName,
    [Parameter(Mandatory=$false)]
    [string]$pfxPassword,
    [Parameter(Mandatory=$true)]
    [string]$herokuApiKey
)

$pfxFileName = "$certName.pfx"

# If the server.crt and server.key files exist, delete them before proceeding
if(Test-Path .\server.crt) {
    Remove-Item .\server.crt
}

if(Test-Path .\server.key) {
    Remove-Item .\server.key
}

# Set the Heroku API Key environment variable
$env:HEROKU_API_KEY=$herokuApiKey

Write-Host "Processing $pfxFileName to PEM format..."
openssl pkcs12 -in .\$pfxFileName -out .\certificate.pem -nodes -passin pass:$pfxPassword

Write-Host "Extracting private key..."
openssl pkey -in .\certificate.pem -out .\server.key

Write-Host "Extracting certificate..."
openssl crl2pkcs7 -nocrl -certfile .\certificate.pem | openssl pkcs7 -print_certs -out .\server.crt

Write-Host "Updating Heroku SSL certificate for app: $herokuAppName..."
#heroku certs:update server.crt server.key --app $herokuAppName

#For new applications use this for the first time
heroku certs:add server.crt server.key --app $herokuAppName

Write-Host "Operation completed successfully!"
