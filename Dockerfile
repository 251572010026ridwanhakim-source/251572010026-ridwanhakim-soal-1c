FROM nginx:alpine

ARG SITE_NAME
ARG TAGLINE
ARG LAUNCH_DATE
ARG OWNER_NAME
ARG CONTACT_EMAIL
ARG BUILD_TIME

COPY index.html style.css /usr/share/nginx/html/

RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    echo "Asia/Jakarta" > /etc/timezone && \
    sed -i "s|SITE_NAME_PLACEHOLDER|${SITE_NAME}|g" /usr/share/nginx/html/index.html && \
    sed -i "s|TAGLINE_PLACEHOLDER|${TAGLINE}|g" /usr/share/nginx/html/index.html && \
    sed -i "s|LAUNCH_DATE_PLACEHOLDER|${LAUNCH_DATE}|g" /usr/share/nginx/html/index.html && \
    sed -i "s|OWNER_NAME_PLACEHOLDER|${OWNER_NAME}|g" /usr/share/nginx/html/index.html && \
    sed -i "s|CONTACT_EMAIL_PLACEHOLDER|${CONTACT_EMAIL}|g" /usr/share/nginx/html/index.html && \
    sed -i "s|BUILD_TIME_PLACEHOLDER|${BUILD_TIME}|g" /usr/share/nginx/html/index.html && \
    apk del tzdata

RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'sed -i "s|RUNTIME_ENV_PLACEHOLDER|${RUNTIME_ENV}|g" /usr/share/nginx/html/index.html' >> /entrypoint.sh && \
    echo 'exec nginx -g "daemon off;"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
