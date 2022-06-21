. ./GitCliSyncOperationOptions.ps1

class GitCliFetchOptions : GitCliSyncOperationOptions {
    [string] $Operation = "fetch";
}
