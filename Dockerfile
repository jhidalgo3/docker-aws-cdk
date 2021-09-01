ARG ALPINE_VERSION=3.14
ARG AWS_CDK_VERSION=1.119.0
FROM alpine:${ALPINE_VERSION}

RUN apk -v --no-cache --update add \
        nodejs \
        npm \
        python3 \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget \
        zip \
        git \
        py-pip \
        && \
    update-ca-certificates && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir awscli s3cmd && \
    npm install -g aws-cdk@${AWS_CDK_VERSION} && \
    npm install -g typescript

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]


# Allow for caching python modules
VOLUME ["/usr/lib/python3.8/site-packages/"]

WORKDIR /opt/app

CMD ["cdk", "--version"]
