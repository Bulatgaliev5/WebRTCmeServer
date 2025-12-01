FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .

RUN dotnet restore WebRTCme.Connection/Signaling/WebRTCme.Connection.Signaling.Server/WebRTCme.Connection.Signaling.Server.csproj

RUN dotnet publish WebRTCme.Connection/Signaling/WebRTCme.Connection.Signaling.Server/WebRTCme.Connection.Signaling.Server.csproj \
    -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "WebRTCme.Connection.Signaling.Server.dll"]
