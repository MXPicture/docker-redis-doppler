ARG BASE_IMAGE=redis
ARG BASE_IMAGE_VERSION=latest
FROM $BASE_IMAGE:$BASE_IMAGE_VERSION

# Install Doppler CLI
RUN wget -q -t3 'https://packages.doppler.com/public/cli/rsa.8004D9FF50437357.key' -O /etc/apk/keys/cli@doppler-8004D9FF50437357.rsa.pub && \
      echo 'https://packages.doppler.com/public/cli/alpine/any-version/main' | tee -a /etc/apk/repositories && \
      apk add doppler

RUN mkdir /var/lib/unit/.doppler \
      && chown -R unit:root /var/lib/unit/.doppler \
      && chmod -R 0700 /var/lib/unit/.doppler

ENTRYPOINT ["doppler", "run", "--", "docker-entrypoint.sh"]
CMD ["redis-server"]