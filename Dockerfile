FROM node:12
WORKDIR /usr/src/app

RUN apt-get update && apt-get -y upgrade &&\
  apt-get install -y curl &&\
  curl -sL https://deb.nodesource.com/setup_12.x | bash -&&\
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -&&\
  echo "deb https://dl.yarnpkg.com/debian/ stable main" |\
    tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update &&\
  apt-get install -y \
  autoconf \
  automake \
  libboost-program-options-dev \
  libbz2-dev \
  cmake \
  expat \
  gdal-bin \
  git \
  libsqlite3-dev \
  libtool \
  nginx \
  nodejs \
  pandoc \
  rapidjson-dev \
  ruby \
  sqlite3 \
  tmux \
  vim \
  xrdp \
  yarn \
  zip \
  zlib1g-dev

RUN mkdir osmium &&\
  cd osmium &&\
  git clone https://github.com/mapbox/protozero &&\
  git clone https://github.com/osmcode/libosmium &&\
  git clone https://github.com/osmcode/osmium-tool &&\
  cd osmium-tool &&\
  mkdir build &&\
  cd build &&\
  cmake .. &&\
  make  &&\
  make install &&\
  cd /usr/src/app &&\
  rm -rf usmium

RUN git clone https://github.com/mapbox/tippecanoe &&\
  cd tippecanoe; make -j3 LDFLAGS="-latomic"; make install; cd .. &&\
  rm -rf tippecanoe

RUN yarn global add browserify budo hjson pm2 rollup @mapbox/mapbox-gl-style-spec @pushcorn/hocon-parser

RUN git clone https://github.com/ibesora/vt-optimizer &&\
  cd vt-optimizer; npm install; cd ..

RUN gem install mdless hocon

COPY . /usr/src/app/

WORKDIR /usr/src/app/

RUN rake inet:install

CMD ["/bin/bash"]