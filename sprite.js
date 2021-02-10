const spritezero = require('@mapbox/spritezero')
const fs = require('fs')
const path = require('path')
const admZip = require('adm-zip')

class Spriter{

  constructor(config){
    this.table = config.get('table')
    this.makiZip = config.get('makiZip')
    this.spriteDir = config.get('spriteDir');
  }

  create(){
    let icons = {};
    const zip = new admZip(path.resolve(__dirname, this.makiZip))
    for (const zipEntry of zip.getEntries()) {
      if (zipEntry.isDirectory) {
        continue
      }
      let ext = path.extname(zipEntry.entryName)
      if (ext !== '.svg'){
        continue;
      }
      let basename = path.basename(zipEntry.entryName);
      icons[basename] = zipEntry.getData()
    }

    for (let pxRatio of [1, 2, 4]) {
      const svgs = this.generateSvgs(icons)
      this.generateSprite(pxRatio, svgs)
    }
  }

  generateSvgs(icons) {
    let svgs = []
    for (let i = 0; i < this.table.length / 2; i++) {
      const id = this.table[2 * i]
      const svgName = `${this.table[2 * i + 1]}-11.svg`
      const svgData = icons[svgName]
      if (!svgData){
        throw new Error(`Invalid icon name: ${id}`)
      }
      svgs.push({
        svg: svgData,
        id: id 
      })
    }
    return svgs
  }

  suffix(pxRatio){
    if (pxRatio === 1) {
      return ''
    } else {
      return `@${pxRatio}x`
    }
  }

  generateSprite(pxRatio, svgs){
    const outputDir = path.resolve(this.spriteDir);
    if (!fs.existsSync(outputDir)){
      fs.mkdirSync(outputDir)
    }
    var pngPath = path.resolve(`${outputDir}/sprite${this.suffix(pxRatio)}.png`);
    var jsonPath = path.resolve(`${outputDir}/sprite${this.suffix(pxRatio)}.json`);

    spritezero.generateLayout({
        imgs: svgs,
        pixelRatio: pxRatio,
        format: true
    }, (err, dataLayout) => {
            if (err) throw err
            fs.writeFileSync(
            jsonPath,
            JSON.stringify(dataLayout, null, 2)
        )
    })
    spritezero.generateLayout({
        imgs: svgs,
        pixelRatio: pxRatio,
        format: false
    }, (err, imageLayout) => {
            if (err) throw err
            spritezero.generateImage(imageLayout, (err, image) => {
            if (err) throw err
            fs.writeFileSync(pngPath, image)
        })
    })
  }
}

const config = require('config')
const spriter = new Spriter(config);
spriter.create();