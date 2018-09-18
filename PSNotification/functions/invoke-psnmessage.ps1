<#
.SYNOPSIS
Send a notification message

.DESCRIPTION
Send a message styled notification 

.PARAMETER Url
The URL endpoint that is capable of handling your request

.PARAMETER ReceiverEmail
The email address of the receiver that you want get the notification

.PARAMETER Subject
The subject of the notification that you want to send

.PARAMETER Message
The body/message of the notification that you want to send

.PARAMETER Json
The raw Json object that you want to pass

.EXAMPLE
Invoke-PSNMessage -ReceiverEmail "admin@domain.com" -Subject "Testing from the new module" -Message "This should arrive at your door steps" -Url "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"

This will invoke the HTTP endpoint and send of a notification styled message / payload. The notification will be sent to "admin@domain.com", with the Subject "Testing from the new module" and the Message "This should arrive at your door steps".

.EXAMPLE
$hashTable = @{email = "admin@domain.com"; subject = "More testing"; message = "I hope this finds you well"}
$payload = ($hashTable | ConvertTo-Json)

Invoke-PSNMessage -Json $payload -Url "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"

This will invoke the HTTP endpoint and send of a notification styled message / payload. The notification details comes from the HashTable that is converted into a Json object.

.EXAMPLE
Set-PSNUrl -Url "https://prod-35.westeurope.logic.azure.com:443/workflows/14adfasdrae23354432636dsfasfdsaf/"
Invoke-PSNMessage -ReceiverEmail "admin@domain.com" -Subject "Testing from the new module" -Message "This should arrive at your door steps"

This will invoke the default HTTP endpoint that has been configured for the module and send of a notification styled message / payload. The notification will be sent to "admin@domain.com", with the Subject "Testing from the new module" and the Message "This should arrive at your door steps".

.EXAMPLE
Invoke-PSNMessage -ReceiverEmail "admin@domain.com" -Subject "Testing from the new module" -Message "This should arrive at your door steps" -AsJob

This will invoke the default HTTP endpoint that has been configured for the module and send of a notification styled message / payload. The notification will be sent to "admin@domain.com", with the Subject "Testing from the new module" and the Message "This should arrive at your door steps". The execution is done in a background job and will not block the execution.

.NOTES

Author: Mötz Jensen (@Splaxi)

#>
function Invoke-PSNMessage {
    [CmdletBinding(DefaultParameterSetName = 'Specific')]
    param (
        [string] $Url = (Get-PSNUrl).Url,

        [Parameter(Mandatory = $True, ParameterSetName = 'Specific')]
        [Alias('Email')]
        [string] $ReceiverEmail,

        [Parameter(Mandatory = $True, ParameterSetName = 'Specific')]
        [string] $Subject,

        [Parameter(Mandatory = $True, ParameterSetName = 'Specific')]
        [string] $Message,

        [Parameter(Mandatory = $True, ParameterSetName = 'Json')]
        [Alias('Payload')]
        [string] $Json,

        [switch] $AsJob,

        [string] $JobName,

        [switch] $EnableException

    )

    begin {
        if(-not $Url) {
            Write-PSFMessage -Level Warning -Message "It seems that you didn't pass a URL and the module doesn't have a configured one to use."
            Stop-PSFFunction -Message "Stopping because of missing URL" -EnableException $EnableException
            return
        }

    }
    
    process {
        if(Test-PSFFunctionInterrupt) {return}

        if ($PSCmdlet.ParameterSetName -eq "Json") {
            Write-PSFMessage -Level Verbose -Message "The execution is a Json payload passed directly."
            $RequestData = $Json
        }
        else {
            Write-PSFMessage -Level Verbose -Message "The execution is a specific parameters passed."
            $RequestData = "{`"email`":`"$ReceiverEmail`", `"message`":`"$Message`", `"subject`":`"$Subject`"}"
        }
        
        if($AsJob.IsPresent) {
            $Arguments  = @{Url = $Url; Payload = $RequestData}
            Start-RSJob -ScriptBlock {
                param($Parameters) 
                Import-Module PSNotification -Force -PassThru 
                Invoke-PSNHttpEndpoint @Parameters
             } -ArgumentList $Arguments  
        }
        else {
            Invoke-PSNHttpEndpoint -Url $Url -Payload $RequestData 
        }
    }
    
    end {
    }
}
