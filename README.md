Azure-ActiveDirectory-PowerShell-For-Admins
===========================================

This repository contains PS1 powerShell Scripts for common Azure Active Directory Administrative tasks.

* ProvisionUsersAndAssignLicenseFromUserListCsv.ps1 - PS1 powerShell script provisions new users, and assigns the AAD_Premium License.  A temporary password assigned to each new user

* Assign_AADPREMIUM_LicenseToAllUsers.ps1 - PS1 powerShell script will find all users who do not have the AAD_PREMIUM license assigned, and assign it to all users in the company (or until available AAD_PREMIUM licenses are consumed). 

* Assign_AADPREMIUM_LicenseToUsersFromCSV.ps1 - PS1 powerShell script will read a list of users from UserList.csv, and assign the AAD_PREMIUM license to users who do not currently have the license. 