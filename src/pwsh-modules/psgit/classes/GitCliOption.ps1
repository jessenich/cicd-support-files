using namespace System.IO;
using namespace System.Collections.Generic;

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
