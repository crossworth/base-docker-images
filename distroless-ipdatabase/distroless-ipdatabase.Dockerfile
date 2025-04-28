# debian:bookworm-slim at 28/Apr/2025 points to sha256:fa5f94fa433728f8df3f63363ffc8dec4adcfb57e4d8c18b44bceccfea095ebc
FROM debian@sha256:b1211f6d19afd012477bd34fdcabb6b663d680e0f4b0537da6e6b0fd057a3ec3 AS downloader

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    unzip \
    tar \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ARG MAXMIND_LICENSE_KEY
ARG IP2LOCATION_TOKEN

RUN mkdir data ip2location && \
    wget -nv -O- "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN&license_key=${MAXMIND_LICENSE_KEY}&suffix=tar.gz" | tar zxv && \
    wget -nv -O- "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=${MAXMIND_LICENSE_KEY}&suffix=tar.gz" | tar zxv && \
    wget -nv "https://www.ip2location.com/download/?token=${IP2LOCATION_TOKEN}&file=PX11LITEBIN" -O ip2location.zip && \
    unzip ip2location.zip -d ip2location && \
    cp -v GeoLite*/*.mmdb data/ && \
    cp -v ip2location/IP2PROXY-LITE-PX11.BIN data/

# https://github.com/GoogleContainerTools/distroless
# gcr.io/distroless/base-debian12@nonroot at 28/Apr/2025 points to sha256:fa5f94fa433728f8df3f63363ffc8dec4adcfb57e4d8c18b44bceccfea095ebc
FROM gcr.io/distroless/base-debian12@sha256:fa5f94fa433728f8df3f63363ffc8dec4adcfb57e4d8c18b44bceccfea095ebc
COPY --from=downloader /app/data /app/data