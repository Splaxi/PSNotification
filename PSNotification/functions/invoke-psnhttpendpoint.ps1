<#
.SYNOPSIS
Invoke a HTTP Endpoint

.DESCRIPTION
Invoke a HTTP Endpoint and send a payload along

.PARAMETER Url
The URL endpoint that is capable of handling your request

The URL parameter has a default value if you have configured one with the designated functions

.PARAMETER Payload
The raw (string) payload that you want to pass along to the HTTP Endpoint

.PARAMETER Type
Type parameter to instruct the HTTP Endpoint what kind of data that will be part of the request

.PARAMETER EnableException
This parameters disables user-friendly warnings and enables the throwing of exceptions.
This is less user friendly, but allows catching exceptions in calling scripts.

.EXAMPLE
$hashTable = @{email = "admin@domain.com"; subject = "More testing"; message = "I hope this finds you well"}
$payload = ($hashTable | ConvertTo-Json)

Invoke-PSNHttpEndpoint -Payload $payload -Url "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"

This will invoke the HTTP endpoint and send along a payload. The payload comes from the HashTable that is converted into a Json object.

.NOTES

Author: Mötz Jensen (@Splaxi)

#>
function Invoke-PSNHttpEndpoint {
    [CmdletBinding()]
    param (
        [string] $Url = (Get-PSNUrl).Url,

        [Parameter(Mandatory = $True)]
        [string] $Payload,

        [ValidateSet('Json')]
        [string] $Type = "Json",

        [switch] $EnableException
    )
    
    begin {
        if (-not $Url) {
            Write-PSFMessage -Level Warning -Message "It seems that you didn't pass a URL and the module doesn't have a configured one to use."
            Stop-PSFFunction -Message "Stopping because of missing URL" -EnableException $EnableException
            return
        }
    }
    
    process {
        if (Test-PSFFunctionInterrupt) {return}
        
        Write-PSFMessage -Level Verbose -Message "Prepping the details for executing the HTTP request."

        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
        $request = [System.Net.WebRequest]::Create($Url)
        $request.Method = "POST"
        $request.ContentType = "application/$($Type.ToLower())";

        try {
            $stream = new-object System.IO.StreamWriter ($request.GetRequestStream())
            $stream.write($Payload)
            $stream.Flush()
            $stream.Close()

            Write-PSFMessage -Level Verbose -Message "Executing the HTTP request."
            $response = $request.GetResponse()
    
            $requestStream = $response.GetResponseStream()
            $readStream = New-Object System.IO.StreamReader $requestStream
            $data = $readStream.ReadToEnd()
        }
        catch {
            Write-PSFMessage -Level Verbose -Message "Something went wrong while contacting the http endpoint." -ErrorRecord $_
        }
        
        $data
    }
    
    end {
    }
}