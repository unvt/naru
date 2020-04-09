# naru
Vector Tile Academy (VTA) code for Raspberry Pi

# background
This repository is the Raspberry Pi implementation for [Vector Tile Academy](https://unvt.github.io/vta).

# use
Log in to your Raspbian and then execute the following.

## install and download (requires internet connection)
```zsh
curl -sL https://unvt.github.io/equinox/install.sh | bash -
git clone https://github.com/unvt/naru.git
cd naru
rake inet:install # install extra software
rake inet:download # donwload source geospatial data for exercise
```

## first time exercise
```zsh
rake tiles
rake style
rake host
```

# shutdown Raspberry Pi
```zsh
sudo poweroff
```
