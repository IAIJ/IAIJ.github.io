# Chat Server Cloudflare Deployment

This repository contains a Flask + Socket.IO chat server.

## Option 1: Deploy to Railway (Recommended for Cloudflare integration)

Railway supports Python apps and works great with Cloudflare DNS/CDN.

### Steps:

1. Create a Railway account at https://railway.app

2. Connect your GitHub repository (push this code to GitHub first)

3. Railway will auto-detect Python and deploy using the Dockerfile

4. Get the Railway domain (e.g., `chat-server.up.railway.app`)

5. In Cloudflare DNS:
   - Add a CNAME record: `odinroom.org` → `chat-server.up.railway.app`
   - Enable Cloudflare proxy (orange cloud)

6. Your site will be live at `https://odinroom.org` with Cloudflare CDN!

## Option 2: Cloudflare Tunnel (Local hosting)

If you prefer to run locally:

1. Install Python dependencies:

   ```powershell
   python -m pip install -r requirements.txt
   ```

2. Install `cloudflared`:
   - https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/

3. Authenticate with Cloudflare:

   ```powershell
   cloudflared tunnel login
   ```

4. Create a tunnel:

   ```powershell
   cloudflared tunnel create chat-server
   ```

5. Update `.cloudflared/config.yml`:
   - set `tunnel: <TUNNEL_ID>` and optionally `credentials-file` if Cloudflare created one
   - confirm the hostname is `odinroom.org`

   If you need Cloudflare DNS routing, run:

   ```powershell
   cloudflared tunnel route dns <TUNNEL_ID> odinroom.org
   ```

6. Run the chat server:

   ```powershell
   python chat.py
   ```

7. Start the tunnel:

   ```powershell
   cloudflared tunnel run chat-server
   ```

## Quick public URL option (temporary)

If you just want a quick public endpoint without a custom hostname:

```powershell
cloudflared tunnel --url http://localhost:5000
```

Then use the generated `trycloudflare.com` URL.

## Notes

- Railway + Cloudflare is the best option for production hosting with your domain.
- Cloudflare Pages is not suitable for this app because it is a dynamic Python Socket.IO server.
- The tunnel exposes your local Flask app securely through Cloudflare.