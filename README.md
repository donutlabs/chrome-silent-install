# Google Chrome Silent Installer

This PowerShell script downloads and installs the latest version of Google Chrome silently.

## Prerequisites

- Windows operating system
- Administrative privileges (Run PowerShell as Administrator)

## Script Overview

1. **Downloads** the latest Google Chrome MSI installer.
2. **Installs** Google Chrome silently.
3. **Cleans up** the installer file after installation.

## Usage

1. **Copy the Script**: Save the following PowerShell script to a file named `chrome-silent-install.ps1`.

    ```powershell
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
    ```

2. **Run the Script**: Open PowerShell as Administrator and execute the script:

    ```powershell
    .\chrome-silent-install.ps1
    ```

## Notes

- Ensure you have sufficient disk space and the necessary permissions to install software.
- If you encounter issues, verify that you are running PowerShell with administrative privileges.

