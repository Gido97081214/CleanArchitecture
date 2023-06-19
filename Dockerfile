############### Base stage ###############
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS base
WORKDIR /app

############### Development stage ###############
FROM base AS development
# Use native linux file polling for better performance
ENV DOTNET_USE_POLLING_FILE_WATCHER 1
WORKDIR /app

# Adds the Entity Framework CLI tools to our path.
RUN dotnet tool install --global dotnet-ef
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY . ./
WORKDIR /app/src/Clean.Architecture.Web

RUN dotnet add package Microsoft.EntityFrameworkCore
RUN dotnet add package Microsoft.EntityFrameworkCore.Analyzers
RUN dotnet add package Microsoft.EntityFrameworkCore.Design

ENTRYPOINT dotnet watch