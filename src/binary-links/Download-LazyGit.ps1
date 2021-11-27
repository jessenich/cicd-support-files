[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Version = "0.30.1",

    # Platform
    [Parameter()]
    [ValidateSet("windows", "macos", "")]
    [string]
    $Platform = "windows",

    # Architecture
    [Parameter()]
    [string]
    [ValidateSet("x86_x64", "armv6", "32-bit")]
    $Architecture = "x86_x64",

    # Format
    [Parameter()]
    [ValidateSet("tar.gz", "zip")]
    [string]
    $Format = "zip"
)

$private:url = "https://github.com/jesseduffield/lazygit/releases/download/v$($Version)/lazygit_$($Version)_$($Platform)_$($Architecture).$($Format)"
Invoke-WebRequest `
    -Uri $private:url `
    -OutFile "lazygit_$($Version)_$($Platform)_$($Architecture).$($Format)" `
    -RetryIntervalSec 3 `
    -MaximumRedirection 3 `
    -MaximumRetryCount 3

