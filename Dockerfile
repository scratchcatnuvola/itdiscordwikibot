# ─── BUILD STAGE ───
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything
COPY . .

# Build ONLY the main project (not the solution with missing tests)
WORKDIR /src/DiscordWikiBot
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# ─── RUNTIME STAGE ───
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
COPY start.sh .
RUN chmod +x start.sh
ENTRYPOINT ["./start.sh"]
