FROM microsoft/dotnet:2.1-sdk-alpine as build
WORKDIR /app

COPY *.sln .
COPY DockerWebApp/*.csproj ./DockerWebApp/
RUN dotnet restore

COPY DockerWebApp/. ./DockerWebApp/
WORKDIR /app/DockerWebApp
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine AS runtime
WORKDIR /app
COPY --from=build /app/DockerWebApp/out ./
ENTRYPOINT ["dotnet", "DockerWebApp.dll"]