FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app

RUN apt-get update&&\
  apt-get -y upgrade&&\
  apt-get -y install curl sudo&&\
  apt-get remove cmdtest&&\
  curl -sL https://deb.nodesource.com/setup_12.x | bash -&&\
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -&&\
  echo "deb https://dl.yarnpkg.com/debian/ stable main" |\
    tee /etc/apt/sources.list.d/yarn.list&&\
  apt-get update&&\
  apt-get install -y\
  autoconf\
  automake\
  bash-completion\
  build-essential\
  cmake\
  cppcheck\
  g++\
  gdal-bin\
  git\
  libboost-program-options-dev\
  libbz2-dev\
  libexpat1-dev\
  libgles2-mesa-dev\
  libglfw3-dev\
  libsqlite3-dev\
  libtool\
  man\
  nano\
  nginx\
  nodejs\
  osmium-tool\
  pkg-config\
  ruby\
  sqlite3\
  tmux\
  vim\
  wget \
  yarn\
  zip\
  zlib1g-dev

RUN git clone https://github.com/mapbox/tippecanoe &&\
  cd tippecanoe; make -j3 LDFLAGS="-latomic"; make install; cd .. &&\
  rm -rf tippecanoe

RUN yarn global add browserify budo hjson pm2 rollup @mapbox/mapbox-gl-style-spec @pushcorn/hocon-parser

RUN gem install mdless hocon dotenv

COPY . /usr/src/app/

WORKDIR /usr/src/app/

RUN rake inet:install

CMD ["/bin/bash"]