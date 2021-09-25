FROM mcr.microsoft.com/dotnet/sdk:3.1 as dev

RUN mkdir /work/
RUN mkdir /daemon_containos/
WORKDIR /work/daemon_containos

COPY ./src/daemon_containos/daemon_containos.csproj /work/daemon_containos/daemon_containos.csproj
RUN dotnet restore

COPY ./src/daemon_containos /work/daemon_containos
RUN mkdir /out/

# RUN find -type d -name bin -prune -exec rm -rf {} \; && find -type d -name obj -prune -exec rm -rf {} \;
RUN dotnet publish --no-restore --output /out/ --configuration Release

FROM mcr.microsoft.com/dotnet/runtime:3.1 as prod

RUN mkdir /app/
RUN mkdir /daemon_containos/
WORKDIR /app/daemon_containos

COPY --from=dev /out/ /app/daemon_containos/
RUN chmod +x /app/daemon_containos/
CMD dotnet daemon_containos.dll