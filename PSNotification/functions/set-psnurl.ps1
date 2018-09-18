<#
.SYNOPSIS
Set the URL for the module

.DESCRIPTION
Register the default URL that the module should be using

.PARAMETER Url
URL of the HTTP Endpoint that you want the module to invoke

.EXAMPLE
Set-PSNUrl -Url "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"

This will set the default URL for the module to "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"

.NOTES

Author: Mötz Jensen (@Splaxi)

#>
function Set-PSNUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Url,

        [switch] $Temporary
    )
    
    end {
        Set-PSFConfig -FullName "psnotification.url" -Value $Url

        if (-not $Temporary) {
            Get-PSFConfig -FullName "psnotification.url" | Register-PSFConfig
    
            Write-PSFMessage -Level Verbose -Message "The URL has been configured and registered."
        }
    }
}