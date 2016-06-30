Azure-ActiveDirectory-PowerShell-For-Admins
===========================================

This repository contains PS1 powerShell Scripts for common Azure Active Directory Administrative tasks.

* ProvisionUsersAndAssignLicenseFromUserListCsv.ps1 - PS1 powerShell script provisions new users, and assigns the AAD_Premium License.  A temporary password assigned to each new user

* Assign_AADPREMIUM_LicenseToAllUsers.ps1 - PS1 powerShell script will find all users who do not have the AAD_PREMIUM license assigned, and assign it to all users in the company (or until available AAD_PREMIUM licenses are consumed). 

* Assign_AADPREMIUM_LicenseToUsersFromCSV.ps1 - PS1 powerShell script will read a list of users from UserList.csv, and assign the AAD_PREMIUM license to users who do not currently have the license. 


## Community Help and Support

We leverage [Stack Overflow](http://stackoverflow.com/) to work with the community on supporting Azure Active Directory and its SDKs, including this one! We highly recommend you ask your questions on Stack Overflow (we're all on there!) Also browser existing issues to see if someone has had your question before. 

We recommend you use the "adal" tag so we can see it! Here is the latest Q&A on Stack Overflow for ADAL: [http://stackoverflow.com/questions/tagged/adal](http://stackoverflow.com/questions/tagged/adal)

## Security Reporting

If you find a security issue with our libraries or services please report it to [secure@microsoft.com](mailto:secure@microsoft.com) with as much detail as possible. Your submission may be eligible for a bounty through the [Microsoft Bounty](http://aka.ms/bugbounty) program. Please do not post security issues to GitHub Issues or any other public site. We will contact you shortly upon receiving the information. We encourage you to get notifications of when security incidents occur by visiting [this page](https://technet.microsoft.com/en-us/security/dd252948) and subscribing to Security Advisory Alerts.

## We Value and Adhere to the Microsoft Open Source Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
