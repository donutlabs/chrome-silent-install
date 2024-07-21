# Define the URL for the latest Chrome MSI installer
$chromeInstallerUrl = "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi"
# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\googlechromestandaloneenterprise64.msi"

try {
    # Download the Chrome installer using WebClient
    Write-Output "Downloading the latest version of Google Chrome..."
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($chromeInstallerUrl, $installerPath)

    # Check if the installer was downloaded successfully
    if (Test-Path $installerPath) {
        Write-Output "Download complete. Installing Google Chrome..."

        # Prepare the MSI installation command
        $msiArgs = "/i `"$installerPath`" /qn /norestart"
        
        # Start the installation process and wait for it to complete
        $process = Start-Process msiexec.exe -ArgumentList $msiArgs -Wait -PassThru

        # Check if Chrome was installed successfully
        if ($process.ExitCode -eq 0) {
            Write-Output "Google Chrome was installed successfully."
        } else {
            Write-Error "Google Chrome installation failed with exit code $($process.ExitCode)."
        }

        # Clean up the installer file
        Remove-Item $installerPath -Force
    } else {
        Write-Error "Failed to download the Chrome installer."
    }
} catch {
    Write-Error "An error occurred: $_"
}
