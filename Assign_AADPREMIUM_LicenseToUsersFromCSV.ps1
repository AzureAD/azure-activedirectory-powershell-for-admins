# this script assigns the AAD_PREMIUM license to users read from a file: userList.csv file

# Authenticate the Administrator
$cred = get-credential
connect-msolservice -credential $cred

# read userList.csv file from a designated filepath
$file = import-csv .\UserList.csv


# get the country's registered countryCode, use as users' default usageLocation if this propery is not set on users
# usage location is required for each user to be licensed
$tenant = Get-MsolCompanyInformation
$defaultCompanyCountryCode = $tenant.CountryLetterCode

#get the tenant's AAD Premium SKUs
$sku=Get-MsolAccountSku | where{$_.SkuPartNumber -ilike "AAD_PREMIUM"}

# check the available unit count - if zero, then exit the script
$availableUnits = $sku.ActiveUnits - $sku.ConsumedUnits
if ($availableUnits -eq 0)
{
  "You have No avaialable AAD_PREMIUM licenses"
  exit
}

#count used for Users successfully assigned a AAD_PREMIUM license
$countOfUsersAssignedAadpLicense = 0;

# read userList.csv file from a designated filepath
$file = import-csv .\UserList.csv

foreach($user in $file)
{
    # read the current user's settings
    $retrievedUser = get-msoluser -userPrincipalName $user.userPrincipalName
    
    $isLicensedWithAADP = $false
    foreach ($lic in $retrievedUser.licenses)
    {
        if($lic.AccountSkuid -ilike "*AAD_PREMIUM*")
        {
        $isLicensedWithAADP = $true                      
        }
    }
   
    # Add AAD Premium license to unlicensed users
    if ($isLicensedWithAADP -eq $false) 
    {
        # if user's usage location is null, then update it using the value from the userList.csv file 
        # Note: the Users' usageLocation is required for license assignment
        #
        if ($retrievedUser.usageLocation -eq $null)
        {
          set-msoluser -UserPrincipalName $user.userPrincipalName -usageLocation $user.usageLocation
        }
               
        # try assigning AADP license to the user
        Try
        {
         # Set-msolUserLicense -UserPrincipalName $user.userPrincipalName -AddLicenses $sku.AccountSkuid
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


