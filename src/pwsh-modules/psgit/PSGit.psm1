using namespace System.Collections.Generic;
using namespace System.IO;

$Script:FindLocalBranchExpression = {
    $epxr = "git branch --show-current";
    $result = Invoke-Expression -Command $epxr;
    return $result;
}

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

class PSGit {

}

class SemanticVersion {
    [int]    $Major;
    [int]    $Minor;
    [int]    $Patch;
    [Nullable[string]] $Prerelease;

    SemanticVersion() {
        $this.Major = 0;
        $this.Minor = 1;
        $this.Patch = 0;
        $this.Prerelease = "";
    }

    SemanticVersion([int] $major, [int] $minor, [int] $patch, [Nullable[string]] $prerelease = $null) {
        $this.Major = major ?? 0;
        $this.Minor = minor ?? $major -eq 0 ? 1 : 0;
        $this.Patch = patch ?? 0;
        $this.Prerelease = prerelease;
    }

    [string] ToString() {
        $str = "$($this.Major.ToString()).$($this.Minor.ToString()).$($this.Patch.ToString())";
        if (![string]::IsNullOrEmpty($this.Prerelease)) {
            $str = "$($str)-$($this.Prerelease)";
        }
        return $str;
    }
}


class GitCliOptions {


    hidden [string] $Paginate;
    hidden [string] $Path;
    hidden [Dictionary[string, psobject]] $Configurations;
    hidden [List[string]] $PassthruArgs;

    GitCliOptions() {
        $this.Paginate = [string]::Empty;
        $this.Path = [string]::Empty;
        $this.Configurations = [Dictionary[string,string]]::new();
        $this.PassthruArgs = [List[string]]::new();
    }

    GitCliOptions([string] $paginate, [string] $path, [IDictionary[string, psobject]] $configurations, [IEnumerable[string]] $passthruArgs) {
        if (!(Test-Path $path)) {
            throw New-GitException "Path '$path' does not exist";
        }
        elseif (!(Test-Path ([Path]::Join($path, ".git")))) {
            throw New-GitException "Path '$path' is not a git repository";
        }

        $this.Paginate = $paginate ?? [string]::Empty;
        $this.Path = $path ?? [string]::Empty;
        $this.Configurations = $configurations ?? [Dictionary[string, psobject]]::new();
        $this.PassthruArgs = $passthruArgs ?? [List[string]]::new();
    }

    [psobject] GetConfigValue([string] $key) {
        if ($this.Configurations.ContainsKey($key)) {
            return $this.Configurations[$key];
        }
        throw [Exception]::new("Configuration key $($key) not found.");
    }

    [psobject] GetConfigValueOrDefault([string] $key) {
        if ($this.Configurations.ContainsKey($key)) {
            return $this.Configurations[$key];
        }
        return (New-Object psobject);
    }

    [psobject] GetConfigValueOrDefault([string] $key, [psobject] $defaultValue) {
        if ($this.Configurations.ContainsKey($key)) {
            return $this.Configurations[$key];
        }
        return $defaultValue ?? (New-Object psobject);
    }

    [string] GetPassthruArg([string] $key) {
        if ($this.PassthruArgs.Contains($key)) {
            return $key;
        }
        throw [Exception]::new("Passthru argument $($key) not found.");
    }

    [string] GetPassthruArgOrDefault([string] $key) {
        if ($this.PassthruArgs.Contains($key)) {
            return $key;
        }
        return [string]::Empty;
    }
}

. "$($PSScriptRoot)/classes/New-GitCliSyncOperationOptions.ps1"
class GitRepositoryOptions {
    [GitCliSyncOperationOptions] $Operations;

    GitRepositoryOptions() {
        $this.Operations = New-GitCliSyncOperationOptions;
    }
}






