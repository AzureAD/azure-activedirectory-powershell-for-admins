# this script assigns the AAD_PREMIUM license to a filtered list of users who do not currently have the AAD_PREMIUM license.
# examples are shown below as possible user filters

# Authenticate the Administrator
$cred = get-credential
connect-msolservice -credential $cred


# get the country's registered countryCode, use as users' default usageLocation if this propery is not set on users
# usage location is required for each user to be licensed
$tenant = Get-MsolCompanyInformation
$defaultCompanyCountryCode = $tenant.CountryLetterCode

#get the tenant's AAD Premium SKU
$sku=Get-MsolAccountSku | where{$_.SkuPartNumber -ilike "AAD_PREMIUM"}

# check the available unit count - if zero, then exit the script
$availableUnits = $sku.ActiveUnits - $sku.ConsumedUnits
if ($availableUnits -eq 0)
{
  "You have No avaialable AAD_PREMIUM licenses"
  exit
}

# the following are example of various filters
# this filters for users who have their departnment property containing "IT"
$users= get-msolUser -EnabledFilter EnabledOnly -MaxResults 1000000 | where{$_.department -ilike "*IT*"}

# this filters for users who have their office property containing "New York"
# $users= get-msolUser -EnabledFilter EnabledOnly -MaxResults 1000000 | where{$_.office -ilike "*New York*"}


# this filters for users who have title containing "Marketing" and in the state that contains "NY"
# $users= get-msolUser -EnabledFilter EnabledOnly -MaxResults 1000000 | where{$_.title -ilike "*Marketing*" -And $_.state -ilike "*NY*"}


"Checking if " + $users.count + " users have the AAD_PREMIUM License"
"if Not, then this script will assign licenses to users from a pool of " + $availableUnits + " available AAD_PREMIUM licenses." 

#count used for Uses successfully assigned a AAD_PREMIUM license
$countOfUsersAssignedAadpLicense = 0;

foreach($user in $users)
{
    $isLicensedWithAADP = $false
    foreach ($lic in $user.licenses)
    {
        if($lic.AccountSkuid -ilike "*AAD_PREMIUM*")
        {
        $isLicensedWithAADP = $true                      
        }
    }
   
    # Add AAD Premium license to unlicensed users
    if ($isLicensedWithAADP -eq $false) 
    {
        # if user's usage location is null, then update it using the company's countryCode - 
        # the Users' usageLocation is required for license assignment
        #
        if ($user.usageLocation -eq $null)
        {
          set-msoluser -UserPrincipalName $user.userPrincipalName -usageLocation $defaultCompanyCountryCode
        }
               
        # try assigning AADP license to the user
        Try
        {
          Set-msolUserLicense -UserPrincipalName $user.userPrincipalName -AddLicenses $sku.AccountSkuid
        
          # decrement the avaialableUnits count
          --$availableUnits

          # increment the number of users assigned an AADP license
          ++$countOfUsersAssignedAadpLicense
          "AAD_PREMIUM license assigned to " + $user.userPrincipalName + " " + $user.displayName
        }

        Catch
        {
           "ERROR attempting to assign AAD_PREMIUM license to user " + $user.userPrincipalName     
        }
        
        # exit when all available AAD_PREMIUM liceses have been assigned
        if ($availableUnits -eq 0)
        {
          "All availalable AAD_PREMIUM licenses have been assigned"
          exit
        }                     
    }
}

"Total number of users assigned an AAD_PREMIUM license: " + $countOfUsersAssignedAadpLicense


