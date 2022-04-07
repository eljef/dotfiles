# Windows

Windows installers are broken up into groups with common scripts between
versions and Windows version specific scripts.

Windows installation scripts also automatically elevate to admin privileges
where needed and will open in new sessions of the correct PowerShell version
needed for runtime.

## Requirements

Windows installation scripts require `winget` to be installed. `winget` is
part of the `App Installer` package. It is installed by default in Windows 11.
You might need to install this manually in Windows 10. You can verify that
`App Installer` is installed, or install it, by visiting the Microsoft Store
page for it.

[App Installer on Microsoft Store](https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab 'App Installer on Microsoft Store')

## Common

Base installation and configuration scripts

## 10

Scripts specific to Windows 10

## 11

Scripts specific to Windows 11
