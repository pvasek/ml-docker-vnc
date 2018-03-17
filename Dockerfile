# based on https://github.com/pytorch/pytorch/blob/master/Dockerfile
FROM pvasek/ml-machine

ENV DEBIAN_FRONTEND noninteractive

# https://cloudcone.com/docs/article/install-desktop-vnc-ubuntu-16-04/
# https://github.com/chenjr0719/Docker-Ubuntu-Unity-noVNC/blob/master/Dockerfile
# https://github.com/Microsoft/vscode/issues/3451

RUN apt-get update \
    && apt-get install -y -f --no-install-recommends \
    ubuntu-desktop \
    unity-lens-applications \
    gnome-panel \
    metacity \
    nautilus \
    gedit \
    xterm \
    tightvncserver \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://go.microsoft.com/fwlink/?LinkID=760868 -o /tmp/vscode.deb \
    && apt-get install -y /tmp/vscode.deb && rm -rf /tmp/vscode.deb \
    && cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/lib/x86_64-linux-gnu/libxcb.so.1.original \
    && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

# for root
RUN chmod -R a+w /workspace

WORKDIR /workspace
COPY home /home

# 5901 vnc
# 5678 remote debugging
EXPOSE 8000 8080 8888 5901 5678
