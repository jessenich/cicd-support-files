class GitException : Exception {
    [string] $Message;
    [string] $ErrorCode;
    [string] $Path;
    [Exception] $InnerException;

    GitException([string] $message, [string] $errorCode) {
        $this.Message = $message;
        $this.ErrorCode = $errorCode;
    }

    GitException([string] $message, [string] $errorCode, [string] $path) {
        $this.Message = $message;
        $this.ErrorCode = $errorCode;
    }

    GitException([string] $message, [string] $errorCode, [string] $path, [Exception] $innerException) {
        $this.Message = $message;
        $this.ErrorCode = $errorCode;
    }

    [string] ToString() {
        return $this.Message;
    }
}
