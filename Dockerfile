FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
WORKDIR /src/DiscordWikiBot
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
COPY start.sh .
RUN chmod +x start.sh
RUN apt-get update && apt-get install -y netcat-openbsd
ENTRYPOINT ["./start.sh"]
And Start.sh to 
#!/bin/bash
echo "$DISCORD_TOKEN" > token.txt

Health check listener for Render
while true; do 
  echo -e "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK" | nc -l -p ${PORT:-10000}
done &

dotnet DiscordWikiBot.dll
