. ./GitCliSyncOperationOptions.ps1

class GitRepositoryOptions {
    [GitCliSyncOperationOptions] $Operations;

    GitRepositoryOptions() {
        $this.Operations = New-GitCliSyncOperationOptions;
    }
}
