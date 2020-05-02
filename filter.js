const Parser = require('json-text-sequence').parser
const modify = require('./modify.js')

const parser = new Parser()
  .on('data', f => {
    process.stdout.write(`\x1e${JSON.stringify(modify(f))}\n`)
  })

process.stdin.pipe(parser)

