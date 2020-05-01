# Basé sur le Dockerfile généré par Visual Studio

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS api-build
WORKDIR /src
COPY ["lern-api/Lern-API/Lern-API.csproj", "Lern-API/"]
RUN dotnet restore "Lern-API/Lern-API.csproj"
COPY ["lern-api/Lern-API/", "Lern-API/"]
WORKDIR "/src/Lern-API"
RUN dotnet build "Lern-API.csproj" -c Release -o /app/build --no-restore

FROM api-build AS api-tests
WORKDIR /src
COPY ["lern-api/Lern-API.Tests/Lern-API.Tests.csproj", "Lern-API.Tests/"]
COPY ["lern-api/Lern-API.Tests/", "Lern-API.Tests/"]
WORKDIR "/src"
COPY ["lern-api/Lern-API.sln", "./"]
RUN dotnet restore "Lern-API.sln"
RUN dotnet test --no-restore -v n

FROM api-build AS api-publish
RUN dotnet publish "Lern-API.csproj" -c Release -o /app/publish --no-restore

FROM node:lts-alpine AS web-build
WORKDIR /usr/src/app
COPY ["lern-web/package.json", "lern-web/package-lock.json", "./"]
RUN npm install
COPY ["lern-web/", "./"]
RUN PUBLIC_URL="/Content" npm run build

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS final
WORKDIR /app
COPY --from=api-publish /app/publish .
COPY --from=web-build /usr/src/app/build ./Content
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "Lern-API.dll"]
