namespace :inet do
  desc 'install extra software for naru'
  task :install do
  end
  
  desc 'download source geospatial data to the place'
  task :download do
    u = "https://download.geofabrik.de/europe/{switzerland-latest.osm.pbf}"
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
end

desc 'build style.json from HOCON descriptions'
task :style do
end

desc 'host the site'
task :host do
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
