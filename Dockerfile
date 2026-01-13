FROM alpine

RUN apk add --no-cache zsh git fzf direnv bat eza vim curl sudo starship;

ARG UID=1000
ARG GID=1000

RUN set -eux; \
    addgroup -S -g ${GID} zsh; \
    adduser -S -u ${UID} -G zsh -h /home/zsh -s /bin/zsh zsh; \
    echo "zsh ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/zsh;

USER zsh

ENV HOME=/home/zsh
WORKDIR /home/zsh

CMD [ "/bin/zsh" ]
