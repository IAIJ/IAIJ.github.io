# Start the Flask chat server and Cloudflare Tunnel.
# Run this from the repository root in PowerShell.
# Note: Run 'cloudflared tunnel login' manually first if not logged in.

Write-Host "Installing dependencies..."
python -m pip install -r requirements.txt

Write-Host "Starting Flask app..."
Start-Job -Name ChatServer -ScriptBlock {
    python "$PSScriptRoot\chat.py"
}

Start-Sleep -Seconds 2

Write-Host "Creating Cloudflare tunnel..."
cloudflared tunnel create chat-server

Write-Host "Please update .cloudflared\config.yml with the tunnel ID from above."
Write-Host "Then run: cloudflared tunnel run chat-server"