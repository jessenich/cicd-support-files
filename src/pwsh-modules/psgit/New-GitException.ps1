

function New-GitException {
    param(
        [Parameter()] $message,
        [Parameter()] $errorCode,
        [Parameter()] $path,
        [Parameter()] $innerException);

    return New-Object GitException $message, $errorCode, $path, $innerException;
}
