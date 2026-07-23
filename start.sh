#!/bin/bash
echo "$DISCORD_TOKEN" > /app/token.txt
dotnet DiscordWikiBot.dll
