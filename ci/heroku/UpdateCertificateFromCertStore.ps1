param(
    [Parameter(Mandatory=$true)]
    [string]$certName,

    [Parameter(Mandatory=$true)]
    [string]$certPassword
)

# Get the certificates from local machine store
$certs = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Subject -like "*$certName*"}

# Check if any certificates were found
if ($certs -eq $null) {
    Write-Error "Certificate $certName not found."
    return
}

# Select the latest certificate
$cert = $certs | Sort-Object NotAfter -Descending | Select-Object -First 1

# Define the path of the PFX file
$certPath = Join-Path -Path (Get-Location).Path -ChildPath "$certName.pfx"

# Delete the existing PFX file if it exists
if (Test-Path $certPath) {
    Remove-Item -Path $certPath -Force
    Write-Output "Deleted existing PFX file at $certPath"
}

# Secure password
$securePassword = ConvertTo-SecureString -String $certPassword -Force -AsPlainText

# Export the certificate with the private key
Export-PfxCertificate -cert $cert.PSPath -FilePath $certPath -Password $securePassword

Write-Output "Latest certificate $certName has been exported to $certPath"
