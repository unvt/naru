REGION = 'australia-oceania'
AREA = 'fiji'

namespace :inet do
  desc 'install extra software for naru'
  task :install do
    sh "yarn"
  end
  
  desc 'download source geospatial data to the place'
  task :download do
    u = "https://download.geofabrik.de/#{REGION}/{#{AREA}-latest.osm.pbf}"
    sh "curl #{u} --output './src/#1'"
  end
  
  desc 'clone and build mapbox-gl-js, and copy to docs'
  task :mbgljs do
  end
  
  desc 'clone and build fonts, and copy to docs'
  task :fonts do
    raise 'to be implemented.'
  end
  
  desc 'clone and build maki, and copy to docs'
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
  sh "parse-hocon hocon/style.conf > docs/style.json"
  sh "gl-style-validate docs/style.json"
  sh "parse-hocon hocon/style.conf"
end

desc 'host the site'
task :host do
  sh "budo -d docs --cors"
end

desc 'build JavaScript code using rollup'
task :js do
end

desc 'run vt-optimizer'
task :optimizer do
end

desc 'run vtshaver'
task :shaver do
end
