def glyphs_generate(fonts_dir, output_dir)
  # Please refer to the below repository how to make glyphs
  # https://github.com/orangemug/font-glyphs
  require 'json'

  sans_fonts_dir = "#{fonts_dir}/opensans"
  if !Dir.exist?("#{sans_fonts_dir}")
    sh "git clone https://github.com/googlefonts/opensans.git #{sans_fonts_dir}"
    sh "cd #{sans_fonts_dir} && git checkout 256dc28b5c && cd ../../"
  end
  glyphs = [
    ["hinted_ttfs/OpenSans-Bold.ttf", "glyphs/Open Sans Bold"],
    ["hinted_ttfs/OpenSans-BoldItalic.ttf", "glyphs/Open Sans Bold Italic"],
    ["hinted_ttfs/OpenSans-CondBold.ttf", "glyphs/Open Sans Cond Bold"],
    ["hinted_ttfs/OpenSans-CondLight.ttf", "glyphs/Open Sans Cond Light"],
    ["hinted_ttfs/OpenSans-CondLightItalic.ttf", "glyphs/Open Sans Cond Light Italic"],
    ["hinted_ttfs/OpenSans-ExtraBold.ttf", "glyphs/Open Sans Extra Bold"],
    ["hinted_ttfs/OpenSans-ExtraBoldItalic.ttf", "glyphs/Open Sans Extra Bold Italic"],
    ["hinted_ttfs/OpenSans-Italic.ttf", "glyphs/Open Sans Italic"],
    ["hinted_ttfs/OpenSans-Light.ttf", "glyphs/Open Sans Light"],
    ["hinted_ttfs/OpenSans-LightItalic.ttf", "glyphs/Open Sans Light Italic"],
    ["hinted_ttfs/OpenSans-Regular.ttf", "glyphs/Open Sans Regular"],
    ["hinted_ttfs/OpenSans-SemiBold.ttf", "glyphs/Open Sans Semi Bold"],
    ["hinted_ttfs/OpenSans-SemiBoldItalic.ttf", "glyphs/Open Sans Semi Bold Italic"]
  ]
  glyphsJson = []
  glyphs.each do |glyph|
    sh "mkdir -p '#{output_dir}/#{glyph[1]}'"
    sh "yarn run build:glyphs #{sans_fonts_dir}/#{glyph[0]} '#{output_dir}/#{glyph[1]}'"
    sh "cp #{sans_fonts_dir}/LICENSE.txt '#{output_dir}/#{glyph[1]}'"
    glyphsJson << glyph[1].split('/')[1]
  end
  File.open("#{output_dir}/glyphs.json","w") {|file| 
    file.puts(JSON.pretty_generate(glyphsJson))
  }
end