# Deployment Script for Messaging System
param(
    [switch]$InstallDependencies = $false
)

function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

function Start-RabbitMQService {
    Write-Host "Starting RabbitMQ service..."
    try {
        $rabbitmqBin = "C:\Program Files\RabbitMQ Server\rabbitmq_server-*\sbin"
        $serviceBat = Join-Path $rabbitmqBin "rabbitmq-service.bat"
        $pluginsBat = Join-Path $rabbitmqBin "rabbitmq-plugins.bat"
        
        if (Test-Path $serviceBat) {
            Start-Process -FilePath $serviceBat -ArgumentList "install" -Verb RunAs -Wait
            Start-Process -FilePath $serviceBat -ArgumentList "start" -Verb RunAs -Wait
            Start-Process -FilePath $pluginsBat -ArgumentList "enable rabbitmq_management" -Verb RunAs -Wait
            Write-Host "RabbitMQ service started"
            return $true
        } else {
            Write-Host "RabbitMQ not found in standard location"
            return $false
        }
    } catch {
        Write-Host "Failed to start RabbitMQ service: $_"
        return $false
    }
}

function Build-JavaProject {
    param($projectPath)
    Write-Host "Building Java project..."
    try {
        Set-Location $projectPath
        javac -cp ".;../lib/*" *.java
        Write-Host "Java project built successfully"
        return $true
    } catch {
        Write-Host "Failed to build Java project: $_"
        return $false
    }
}

# Main execution
Write-Host "Starting deployment process..."

# Check Java installation
if (-not (Test-CommandExists "javac")) {
    Write-Host "Java JDK not found. Please install it first."
    Write-Host "Download from: https://www.oracle.com/java/technologies/downloads/"
    exit 1
}

# Start RabbitMQ service
if (-not (Start-RabbitMQService)) {
    exit 1
}

# Build Java project
$projectPath = Join-Path $PSScriptRoot "..\MessagingSystem"
if (-not (Build-JavaProject $projectPath)) {
    exit 1
}

Write-Host "Deployment completed successfully"