FROM alpine:latest

# လိုအပ်သော packages များသွင်းခြင်း
RUN apk add --no-cache curl unzip caddy

WORKDIR /app

# Xray core install လုပ်ခြင်း
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip && chmod +x xray && rm -f xray.zip

# Cloudflared install လုပ်ခြင်း
RUN curl -L -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x cloudflared

# လက်ရှိဖိုင်များအားလုံးကို copy ကူးခြင်း
COPY . .

# Railway PORT (Xray အတွက် 8080 ကို သုံးပါမယ်)
EXPOSE 8080

# Xray, Caddy နဲ့ Cloudflare Tunnel ကို run ရန် script
# TUNNEL_TOKEN ကို Railway Environment Variable မှာ ထည့်ပေးရပါမယ်
CMD ./xray -config config.json & \
    caddy file-server --listen :8081 --root /app & \
    ./cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}
