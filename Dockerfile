FROM ubuntu:26.04@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

# GNU Awk 5.3.2, API 4.0, PMA Avon 8-g1, (GNU MPFR 4.2.2, GNU MP 6.3.0)
# Bats 1.13.0
# GNU bash, version 5.3.9(1)-release (x86_64-pc-linux-gnu)
# jq-1.8.1

RUN apt-get update                                                              && \
    apt-get install --assume-yes --no-install-recommends gawk jq bats locales   && \
    sed --in-place '/en_US.UTF-8/s/^# //g' /etc/locale.gen                      && \
    locale-gen                                                                  && \
    apt-get purge --auto-remove --assume-yes                                    && \
    apt-get clean                                                               && \
    rm --recursive --force /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

WORKDIR /opt/test-runner
COPY . .
ENV BATS_RUN_SKIPPED=true
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
