#!/bin/bash
echo "$DISCORD_TOKEN" > token.txt

Health check listener for Render
while true; do 
  echo -e "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK" | nc -l -p ${PORT:-10000}
done &

dotnet DiscordWikiBot.dll
