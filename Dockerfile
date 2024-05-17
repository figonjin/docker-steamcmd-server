FROM ich777/winehq-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl unzip jq lib32gcc-s1 screen xvfb winbind xauth && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV VR_NAME="V Rising Docker"
ENV VR_SAVE_NAME="world1"
ENV GAME_NAME="template"
ENV VR_DESCRIPTION="Lorem Ipsum"
ENV VR_GAME_PORT=27015
ENV VR_QUERY_PORT=27016
ENV VR_PASSWORD=""
ENV VR_LOWER_FPS_WHEN_EMPTY=true
ENV VR_LOWER_FPS_WHEN_EMPTY_VALUE=15
ENV VR_PRESET=StandardPvE
ENV VR_DIFFICULTY_PRESET=Difficulty_Brutal
ENV VR_RCON_ENABLED=false
ENV VR_RCON_PORT=25575
ENV VR_RCON_PASSWORD="rconditioner"  
ENV VR_LIST_ON_STEAM=false
ENV VR_LIST_ON_EOS=false
ENV ENABLE_BEPINEX=""
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
