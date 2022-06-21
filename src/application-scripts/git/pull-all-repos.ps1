#Requires -PSEdition Core
#Requires -Version 6.1.0
#Requires -Assembly 'System.IO, Version=5.0.0.0'

using namespace System.IO;

[CmdletBinding()]
param(
    [Parameter(Mandatory, ValueFromPipeline, Position = 0, ParameterSetName = 'fetch,pull')]
    [ValidateNotNullOrEmpty]
    [DirectoryInfo]
    $InputObject = $env:PWD,

    # Perform git fetch operation on InputObject
    [Parameter(ParameterSetName = 'fetch')]
    [switch]
    $NoFetch = $false,

    # Performs a git fetch --all. This stacks with fetch -v
    [Parameter(ParameterSetName = 'fetch')]
    [switch]
    $FetchAll = $false,

    # Perform git pull operation on InputObject
    [Parameter(ParameterSetName = 'pull')]
    [switch]
    $NoPull = $false,

    # Perform git pull --all on  InputObject. Operation compounds with -PullVerbose, but negated by -NoPull
    [Parameter(ParameterSetName = 'pull')]
    [ParameterType]
    $PullAll = $false,

    # Perform git pull --all -v on InputObject. Operation compounds with -PullAll, but negated by -NoPull
    [Parameter(ParameterSetName = 'pull')]
    [ParameterType]
    $PullVerbose = $false,

    # Performs, git fetch origin HEAD & git pull origin HEAD on InputObect. Negated by -NoFetch and -NoPull, respectively.
    [Parameter(ParameterSetName = 'pull,fetch')]
    [string]
    $Origin = 'origin'
)

begin {

    $Script:FetchExpression = {
        $expr = "git fetch";
        if ($Options.Operations.AppendAllSwitch) {
            $expr += " --all";
        }

        if ($Options.Operations.AppendVerboseSwitch) {
            $expr += " --verbose";
        }

        $result = Invoke-Expression $expr;
        return $result;
    }

    $Script:PullExpression = {
        $expr = 'git pull';
        if ($Origin) {
            $expr += " $Origin HEAD";
        }

        if ($PullAll) {
            $expr += ' --all';
        }

        if ($PullVerbose) {
            $expr += ' -v';
        }

        $result = Invoke-Expression $expr;
        return $result
    }
}

process {
    Get-ChildItem - -Depth 1 -FollowSymlink -Directory -Include '.git' -Hidden | Select-Object -ExpandProperty FullName | ForEach-Object -Process {
        $directory = $PSItem.Replace('/.git', [string]::Empty);
        $branch =
        if (!(Test-Path $directory)) {
            "Found $($directory), but no repo initialized. Skipping." | Write-Warning;
            continue;
        }

        "Found $($directory). Performing pull on branch $($branch)" | Write-Information;
        Write-Host -BackgroundColor DarkCyan -ForegroundColor DarkRed -Object "Performing pull for repo '$($directory)'"
    }
}
