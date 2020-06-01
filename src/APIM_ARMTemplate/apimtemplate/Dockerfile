# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

COPY ./*.csproj ./
RUN dotnet restore

COPY ./. ./
WORKDIR /source/
RUN dotnet publish -c release -o /app --self-contained false --no-restore

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

RUN apk add --no-cache curl tar openssl sudo bash jq python3
RUN apk --update --no-cache add postgresql-client postgresql
RUN apk add --virtual=build gcc libffi-dev musl-dev openssl-dev make python3-dev
RUN pip3 install --upgrade pip 
RUN pip3 install azure-cli

ENV TZ Europe/London

WORKDIR /app
COPY --from=build /app ./
RUN mkdir /extracted
RUN chmod +x ./

ENTRYPOINT ["dotnet", "apimtemplate.dll"]
