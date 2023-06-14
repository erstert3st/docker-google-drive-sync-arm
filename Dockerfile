FROM ubuntu:18.04


RUN apt-get update \
      && apt-get -y install curl unzip node npm \
      && curl -O https://downloads.rclone.org/rclone-current-linux-arm.zip \
      && unzip rclone-current-linux-arm.zip \
      && cp rclone-*-linux-arm/rclone /usr/bin/ \
      && chown root:root /usr/bin/rclone \
      && chmod 755 /usr/bin/rclone \
      && apt-get clean \
      && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* /rclone-current-linux-amd64.zip



COPY ./package.json /usr/local/bin/google-sync/package.json
COPY ./package-lock.json /usr/local/bin/google-sync/package-lock.json
COPY ./lib /usr/local/bin/google-sync/lib
COPY ./etc /usr/local/bin/google-sync/etc
COPY ./etc/rclone.conf /root/.config/rclone/rclone.conf.example

WORKDIR /usr/local/bin/google-sync

RUN  npm install --production

CMD ["npm", "start"]
