function Get-LoggedOnUser {
     <#
    .Synopsis
       Gets the logged in user of the station
    .DESCRIPTION
       Uses WMI to get the user who is logged in while stripping out the common SIDS
    .EXAMPLE
       Get-LoggedOnUser
    .EXAMPLE
       Get-LoggedOnUser -ComputerName Some-Computer
    .INPUTS
       will accept values from the pipeline: "Computer", "__SERVER", "IPAddress"
    .OUTPUTS
       Will output type: System.Management.ManagementObject#root\cimv2\Win32_UserProfile
    .NOTES
       General notes
    #>
    [CmdletBinding()]
    Param (

        # Specify the name of one or more computers
        [Parameter(
            Position = 0,
            Mandatory = $false, 
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true, 
            ParameterSetName = 'Computer'
        )]
        [Alias("Computer", "__SERVER", "IPAddress")] 
        $ComputerName = $env:COMPUTERNAME

    )
    #can filter out common sids that appear
    $commonSIDS = @(
        ".DEFAULT",
        "S-1-5-18",
        "S-1-5-19",
        "S-1-5-20",
        "_Classes"
    )
    
    $wmiLoadedUser = Get-WmiObject win32_userprofile -ComputerName $computerName | Where-Object{$_.loaded -eq $true -and $_.SID -notmatch ($commonSIDS -join '|') } 
    $wmiLoadedUser


}