﻿@{
    # Script module or binary module file associated with this manifest
    ModuleToProcess   = 'PSNotification.psm1'
	
    # Version number of this module.
    ModuleVersion     = '0.5.2'
	
    # ID used to uniquely identify this module
    GUID              = '4d19341d-fefb-46c7-b5c6-ee7c527615a4'
	
    # Author of this module
    Author            = 'Mötz Jensen'
	
    # Company or vendor of this module
    CompanyName       = 'Essence Solutions'
	
    # Copyright statement for this module
    Copyright         = 'Copyright (c) 2018 Mötz Jensen'
	
    # Description of the functionality provided by this module
    Description       = 'Small module that enables you to call any kind of HTTP endpoint'
	
    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'
	
    # Modules that must be imported into the global environment prior to importing
    # this module
    RequiredModules   = @(
        @{ ModuleName = 'PSFramework'; ModuleVersion = '0.9.25.113' },
        @{ ModuleName = 'PoshRSJob'; ModuleVersion = '1.7.4.4' }
    )
	
    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @('bin\PSNotification.dll')
	
    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @('xml\PSNotification.Types.ps1xml')
	
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @('xml\PSNotification.Format.ps1xml')
	
    # Functions to export from this module
    FunctionsToExport = @(
        'Get-PSNUrl',
        'Invoke-PSNHttpEndpoint',
        'Invoke-PSNMessage',
        'Set-PSNUrl'
		
    )
	
    # Cmdlets to export from this module
    CmdletsToExport   = ''
	
    # Variables to export from this module
    VariablesToExport = ''
	
    # Aliases to export from this module
    AliasesToExport   = ''
	
    # List of all modules packaged with this module
    ModuleList        = @()
	
    # List of all files packaged with this module
    FileList          = @()
	
    # Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{
		
        #Support for PowerShellGet galleries.
        PSData = @{
			
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()
			
            # A URL to the license for this module.
            # LicenseUri = ''
			
            # A URL to the main website for this project.
            # ProjectUri = ''
			
            # A URL to an icon representing this module.
            # IconUri = ''
			
            # ReleaseNotes of this module
            # ReleaseNotes = ''
			
        } # End of PSData hashtable
		
    } # End of PrivateData hashtable
}