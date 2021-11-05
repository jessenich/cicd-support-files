. $PSScriptRoot/classes/GitException.ps1;
. $PSScriptRoot/classes/SemanticVersion.ps1;
. $PSScriptRoot/classes/GitCliOption.ps1;
. $PSScriptRoot/classes/GitRepositoryOptions.ps1;
. $PSScriptRoot/classes/GitCliSyncOperationOptions.ps1;
. $PSScriptRoot/classes/GitCliFetchOptions.ps1;
. $PSScriptRoot/classes/GitCliPushOptions.ps1;
. $PSScriptRoot/functions/New-GitException.ps1;
. $PSScriptRoot/functions/New-GitCliSyncOperationOptions.ps1;

$FindLocalBranchExpression = {
    $epxr = "git branch --show-current";
    $result = Invoke-Expression -Command $epxr;
    return $result;
}

$FetchExpression = {
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

$PullExpression = {
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









