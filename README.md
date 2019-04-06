# Anonimous password checker

This PowerShell script check if you have an account that has been compromised in a data breach without sending your password or it's hash 
to 3rd party services. If you don't trust your data to 3rd party services like [Haveibeenpwned.com](https://haveibeenpwned.com/) 
this script for you.

## System requirements
PowerShell (integrated to Windows 7 and greather)

## Usage
1. Save script to your local machine
2. Right mouse click to icon of *pass-check.ps1* (or *pass-check*)
3. Click to "Run with PowerShell" option
4. Enter your password and press "Enter"
6. Script makes several simple actions and show result

**If your result is "Found 0"** - Great! Your password not found in database and has not been compromised. 
**If your result is like "Found 2353443"** - Bad news! Your password was found in database and has been compromised. 
You should change this password now.

## How password checking works
Password checking working on method descibed on [article](https://blog.cloudflare.com/validating-leaked-passwords-with-k-anonymity/).
In simple describe this process looks like:

1. You run the script on your local machine and enter your password
2. Getting hash of entered password
3. Getting first 5 symbols of password hash
4. Sending first 5 symbols of password hash to Haveibeenpwned.com API
5. Haveibeenpwned.com API responses with range of hashes from DB started from cpecified 5 symbols
7. Searching hash of your password in range of recieved hashes
