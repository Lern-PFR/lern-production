# Basé sur le Dockerfile généré par Visual Studio

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS api-build
WORKDIR /src
COPY ["lern-api/Lern-API/Lern-API.csproj", "Lern-API/"]
RUN dotnet restore "Lern-API/Lern-API.csproj"
COPY ["lern-api/Lern-API/", "Lern-API/"]
WORKDIR "/src/Lern-API"
RUN dotnet build "Lern-API.csproj" -c Release -o /app/build --no-restore

FROM api-build AS api-tests
WORKDIR /src
COPY ["lern-api/Lern-API.Tests/Lern-API.Tests.csproj", "Lern-API.Tests/"]
COPY ["lern-api/", "./"]
WORKDIR "/src"
COPY ["lern-api/Lern-API.sln", "./"]
RUN dotnet restore "Lern-API.sln"
RUN dotnet test --no-restore -v n "Lern-API.sln"

FROM api-build AS api-publish
RUN dotnet publish "Lern-API.csproj" -c Release -o /app/publish --no-restore

FROM node:lts-alpine AS web-build
WORKDIR /usr/src/app
COPY ["lern-web/package.json", "lern-web/yarn.lock", "./"]
RUN yarn install
COPY ["lern-web/", "./"]
RUN REACT_APP_API_URL="" PUBLIC_URL="/" yarn build

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=api-publish /app/publish .
COPY --from=web-build /usr/src/app/build ./Content
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "Lern-API.dll"]
