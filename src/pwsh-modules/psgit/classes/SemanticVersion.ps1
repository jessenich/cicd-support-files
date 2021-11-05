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
