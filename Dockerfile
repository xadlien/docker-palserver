FROM ubuntu:22.04 AS DOWNLOAD

# install steamcmd dependencies 
RUN apt update && apt install -y \
lib32gcc-s1 \
software-properties-common \
sudo

# enable multiverse
RUN add-apt-repository multiverse

# enable 32 bit 
RUN dpkg --add-architecture i386

# preseed answers for installs
RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN echo steam steam/license note '' | debconf-set-selections

# install steamcmd
RUN apt update && apt install -y steamcmd 

# create palserver user
RUN useradd -d /home/palserver --shell /bin/bash palserver -m
USER palserver

# download palworld server
RUN /usr/games/steamcmd +force_install_dir /home/palserver +login anonymous +app_update 2394010 validate +quit

# fix for errors related to running server
RUN mkdir -p /home/palserver/.steam/sdk64/
RUN /usr/games/steamcmd +login anonymous +app_update 1007 +quit
RUN cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/

# copy in template for server config
COPY PalWorldSettings.ini /home/palserver/

# copy in entrypoint
COPY entrypoint.sh /home/palserver/

# set user to root for mount setup at start
USER root
WORKDIR /home/palserver/

CMD ["/bin/bash", "./entrypoint.sh"]