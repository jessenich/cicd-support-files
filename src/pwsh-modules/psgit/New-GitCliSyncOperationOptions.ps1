




function New-GitCliSyncOperationOptions {
    param(
        [Parameter()]
        [bool] $AppendAllSwitch = $false,

        [Parameter()]
        [bool] $AppendVerboseSwitch = $false,

        [Parameter(Mandatory = $true)]
        [ValidateSet("fetch", "pull")]
        [string] $Operation
    )

    $options = $Operation -eq "fetch" ? (New-Object GitCliFetchOptions) : (New-Object GitCliPullOptions);
    $options.AppendAllSwitch = $AppendAllSwitch;
    $options.AppendVerboseSwitch = $AppendVerboseSwitch;
    return $options;
}
