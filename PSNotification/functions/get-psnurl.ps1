<#
.SYNOPSIS
Get the module URL

.DESCRIPTION
Gets the registered default URL that the module is using

.EXAMPLE
Get-PSNUrl

This will return a PSCustomObject containing the URL registered for the module

.NOTES

Author: Mötz Jensen (@Splaxi)

#>
function Get-PSNUrl {
    [CmdletBinding()]
    param (
    )
    
    end {
        [PSCustomObject]@{Url = (Get-PSFConfigValue -FullName "psnotification.url")}
    }
}