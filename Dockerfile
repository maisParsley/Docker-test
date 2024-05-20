ARG DOTNET_RUNTIME=mcr.microsoft.com/dotnet/aspnet:8.0
ARG DOTNET_SDK=mcr.microsoft.com/dotnet/sdk:8.0

FROM ${DOTNET_RUNTIME} AS base
ENV ASPNETCORE_URLS=http://+:7105
WORKDIR /EFGetStarted
EXPOSE 7105

# Base for build
FROM ${DOTNET_SDK} AS buildbase
WORKDIR /EFGetStarted

# Copy everything
COPY . ./
RUN dotnet restore EFGetStarted.sln

## Run migrations
FROM buildbase as migrations
RUN dotnet tool install --version 8.0.5 --global dotnet-ef
ENV PATH="$PATH:/root/.dotnet/tools"
ENTRYPOINT dotnet-ef database update --project /EFGetStarted --startup-project /EFGetStarted