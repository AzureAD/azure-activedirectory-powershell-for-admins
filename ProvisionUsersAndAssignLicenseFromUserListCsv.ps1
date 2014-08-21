<#
This script provisions new users int Azure AD from UserList.csv file, with userPrincipalName,displayName,password,usageLocation,licenseToAssign
#>

# Authenticate the Administrator
$cred = get-credential
connect-msolservice -credential $cred

# read input.csv file from a designated filepath
$file = import-csv .\UserList.csv

# counter used to display the number of users processes
$numberOfUsersProcessed = 0;

# process each input.csv line item:  userPrincpalName,displayName and password
foreach ($user in $file)
{
   # display values from each line
   $user.userPrincipalName + "   " + $user.DisplayName + "   " + $user.password
   
   # provision a new user, which geneate a random temp password
   New-MsolUser -UserPrincipalName $user.userPrincipalName -DisplayName $user.displayName -StrongPasswordRequired $false -usageLocation $user.usageLocation
   
   # set the newly created user's initial (temp) password, and require the user to reset it during initial logon
   Set-MsolUserPassword -UserPrincipalName $user.userPrincipalName -NewPassword $user.password -ForceChangePassword $true
   
     # assign License
   Set-MsolUserLicense -UserPrincipalName $user.userPrincipalName -AddLicenses $user.licenseToAssign

    
   # display number of users processes 
   ++$numberOfUsersProcessed
     $numberOfUsersProcessed
}
 
# end of script