FROM mcr.microsoft.com/dotnet/sdk:3.1 as dev

RUN mkdir /work/
RUN mkdir /web_containos/
WORKDIR /work/web_containos

COPY ./src/web_containos/web_containos.csproj /work/web_containos/web_containos.csproj
RUN dotnet restore

COPY ./src/web_containos /work/web_containos
RUN mkdir /out/

# RUN find -type d -name bin -prune -exec rm -rf {} \; && find -type d -name obj -prune -exec rm -rf {} \;
RUN dotnet publish --no-restore --output /out/ --configuration Release

FROM mcr.microsoft.com/dotnet/aspnet:3.1 as prod

RUN mkdir /app/
RUN mkdir /web_containos/
WORKDIR /app/web_containos

COPY --from=dev /out/ /app/web_containos/
RUN chmod +x /app/web_containos/
CMD dotnet web_containos.dll