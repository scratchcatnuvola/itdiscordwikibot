# ─── BUILD STAGE ───
# Use the .NET SDK image to compile the code
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything from the repo into the container
COPY . .

# Restore NuGet packages and build in Release mode
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# ─── RUNTIME STAGE ───
# Use the smaller .NET runtime image (no SDK needed to run)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the compiled files from the build stage
COPY --from=build /app/publish .

# Copy the startup script
COPY start.sh .
RUN chmod +x start.sh

# Run the startup script when the container starts
ENTRYPOINT ["./start.sh"]
