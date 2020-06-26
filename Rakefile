#REGION = 'australia-oceania'
REGION = 'africa'
#AREA = 'new-zealand'
AREA = 'kenya'

namespace :inet do
  desc 'install extra software for naru'
  task :install do
    sh "yarn"
  end
  
  desc 'download source geospatial data to the place'
  task :download do
    u = "https://download.geofabrik.de/#{REGION}/{#{AREA}-latest.osm.pbf}"
    sh "curl -C - #{u} --output './src/#1'"
  end
  
  desc 'TODO: clone and build mapbox-gl-js, and copy to docs'
  task :mbgljs do
    raise 'to be implemented.'
  end
  
  desc 'TODO: clone and build fonts, and copy to docs'
  task :fonts do
    raise 'to be implemented.'
  end
  
  desc 'TODO: clone and build maki, and copy to docs'
  task :sprite do
    raise 'to be implemented.'
  end
end

desc 'build tiles from source data'
task :tiles do
  sh "osmium export --config osmium-export-config.json --index-type=sparse_file_array --output-format=geojsonseq --output=- src/#{AREA}-latest.osm.pbf | node filter.js | tippecanoe --no-feature-limit --no-tile-size-limit --force --simplification=2 --maximum-zoom=15 --base-zoom=15 --hilbert --output=tiles.mbtiles"
  sh "tile-join --force --no-tile-compression --output-to-directory=docs/zxy --no-tile-size-limit tiles.mbtiles"
end

desc 'build style.json from HOCON descriptions'
task :style do
  require 'json'
  sh "parse-hocon hocon/style.conf > docs/style.json"
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

desc 'TODO: build JavaScript code using rollup'
task :js do
end

desc 'TODO: run vt-optimizer'
task :optimizer do
end

