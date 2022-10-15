ADD file:2a949686d9886ac7c10582a6c29116fd29d3077d02755e87e111870d63607725 in / 

CMD ["/bin/sh"]

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
/bin/sh -c apk add --no-cache fontconfig libretls musl-locales musl-locales-lang ttf-dejavu tzdata zlib     && rm -rf /var/cache/apk/*

ENV JAVA_VERSION=jdk-17.0.4+8
/bin/sh -c set -eux;     ARCH="$(apk --print-arch)";     case "${ARCH}" in        amd64|x86_64)          ESUM='9d5a1fc83b3e74efb25d1ec3767aa6d29e9439c46e5855cfbd59eff3e9978529';          BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.4%2B8/OpenJDK17U-jre_x64_alpine-linux_hotspot_17.0.4_8.tar.gz';          ;;        *)          echo "Unsupported arch: ${ARCH}";          exit 1;          ;;     esac; 	  wget -O /tmp/openjdk.tar.gz ${BINARY_URL}; 	  echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; 	  mkdir -p /opt/java/openjdk; 	  tar --extract 	      --file /tmp/openjdk.tar.gz 	      --directory /opt/java/openjdk 	      --strip-components 1 	      --no-same-owner 	  ;     rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
/bin/sh -c echo Verifying install ...     && echo java --version && java --version     && echo Complete.

ENV MINECRAFT_VERSION=1.19.2
ENV MEMORY=26G

WORKDIR /data

VOLUME [/data/worlds /data/plugins/squaremap/web]
COPY start.sh / # buildkit

RUN /bin/sh -c apk add --no-cache         curl         jq &&     chmod u+x /start.sh # buildkit
CMD ["/bin/sh" "-c" "/start.sh"]

