# Railway VLESS (Xray)
# အကောင်းဆုံးနဲ့အလွယ်ကူးဆုံးဆိုက်ဖြစ်ပါတယ်
## Deploy
- Fork / Upload this repo to GitHub
- Create Railway project
- Deploy from GitHub
- Add Variable: PORT=8080

## Cloudflare
- DNS CNAME → Railway domain
- Proxy ON

## Client
- Protocol: VLESS
- Network: WS
- Path: /vless
- TLS: ON
- Port: 443
