require 'dotenv/load' #load environmental variable from .env

REGION = ENV['REGION']
AREA = ENV['AREA']
MBTILES = "src/tiles.mbtiles"
SITE_ROOT = ENV['SITE_ROOT'] || 'http://localhost:9966'

namespace :inet do
  desc 'install extra software for naru'
  task :install do
    sh "yarn"
  end
  
  desc 'download source geospatial data to the place'
  task :download do
    if !File.exist?("src/#{AREA}-latest.osm.pbf")
      u = "https://download.geofabrik.de/#{REGION}/{#{AREA}-latest.osm.pbf}"
      sh "curl -C - #{u} --output './src/#1'"
    end
  end
  
  desc 'clone and build mapbox-gl-js, and copy to docs'
  task :mbgljs do
    SRC_DIR="./src/js"
    DIST_DIR="./docs/js"
    if !Dir.exist?("#{SRC_DIR}")
      sh "git clone https://github.com/unvt/js.git #{SRC_DIR}"
    end
    if !Dir.exist?("#{DIST_DIR}")
      sh "mkdir -p #{DIST_DIR}"
    end
    sh "cp #{SRC_DIR}/docs/mapbox-gl.css '#{DIST_DIR}/.'"
    sh "cp #{SRC_DIR}/docs/mapbox-gl.js '#{DIST_DIR}/.'"
  end
  
  desc 'clone and build fonts, and copy to docs'
  task :fonts do
    require './glyphs_generate'
    FONTS_DIR="./src"
    OUTPUTS_DIR="./docs"
    glyphs_generate(FONTS_DIR, OUTPUTS_DIR)
  end
  
  desc 'clone and build maki, and copy to docs'
  task :sprite do
    u = "https://github.com/mapbox/maki/zipball/master"
    dest = "./src/maki"
    if !File.exist?("#{dest}.zip")
      sh "wget -O #{dest}.zip #{u}"
    end
    sh "node sprite.js"
  end
end

desc 'build tiles from source data'
task :tiles do
  sh "osmium export --config osmium-export-config.json --index-type=sparse_file_array --output-format=geojsonseq --output=- src/#{AREA}-latest.osm.pbf | node filter.js | tippecanoe --no-feature-limit --no-tile-size-limit --force --simplification=2 --maximum-zoom=15 --base-zoom=15 --hilbert --output=#{MBTILES}"
  sh "tile-join --force --no-tile-compression --output-to-directory=docs/zxy --no-tile-size-limit #{MBTILES}"
end

desc 'build style.json from HOCON descriptions'
task :style do
  require 'json'
  sh "site_root=#{SITE_ROOT} parse-hocon hocon/style.conf > docs/style.json"
  center = JSON.parse(File.read('docs/zxy/metadata.json'))['center'].split(',')
    .map{|v| v.to_f }.slice(0, 2)
  style = JSON.parse(File.read('docs/style.json'))
  style['center'] = center
  File.write('docs/style.json', JSON.pretty_generate(style))
  sh "gl-style-validate docs/style.json"
end

desc 'host the site'
task :host do
  sh "budo -d docs --cors"
end

desc 'build JavaScript code using rollup'
task :js do
  sh "yarn run build:js"
end

desc 'run vt-optimizer'
task :optimizer do
  sh "yarn run optimiser -m #{MBTILES}"
end

