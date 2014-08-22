Azure-ActiveDirectory-PowerShell-For-Admins
===========================================

This repository contains PS1 powerShell Scripts for common Azure Active Directory Administrative tasks.

* ProvisionUsersAndAssignLicenseFromUserListCsv.ps1 - this simple PS1 powerShell script provisions new users, and assigns the AAD_Premium License.

* Assign_AADPREMIUM_LicenseToAllUsers.ps1 - this script will find all users who do not have the AAD_PREMIUM license assigned, and assign it to all users in the company (or until available AAD_PREMIUM licenses are consumed). 