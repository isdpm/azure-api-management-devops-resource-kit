# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY ./* ./
RUN dotnet restore
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
RUN chmod +x ./

# RUN dotnet run extract

ENTRYPOINT ["dotnet", "apimtemplate.dll", "extract"]