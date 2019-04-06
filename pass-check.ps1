$RequestURL = "https://api.pwnedpasswords.com/range"
$securePassword = Read-Host "Enter Password" -AsSecureString
$Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

[Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
$hash = [System.Web.Security.FormsAuthentication]::HashPasswordForStoringInConfigFile($Password, "SHA1")
$hashPrefix = $hash.Substring(0,5) # Get first 5 hash symbols
$hashSuffix = $hash.Substring(5)

Write-Output "Sending GET request" $RequestURL/$hashPrefix

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" # This is required because PowerShell defaults to TLS and Troy Hunt's site will only use TLS 1.2.
$webResponse = Invoke-WebRequest -Uri $RequestURL/$hashPrefix

[int]$result = ($webResponse.Content.Split("`n") | Select-String $hashSuffix) -split ':' | Select-Object -Last 1

Write-Output "Found" $result
							
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
