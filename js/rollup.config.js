import nodeResolve  from '@rollup/plugin-node-resolve'
import commonjs     from '@rollup/plugin-commonjs'
import babel        from '@rollup/plugin-babel'
import css from "rollup-plugin-import-css"

export default {
  input: "js/index.js",
  output: [
    {
      file: "docs/js/bundle.js",
      name: "bundle",
      format: "esm",
      sourcemap: true,
    }
  ],
  plugins: [
    nodeResolve(),
    commonjs(), 
    babel({
      include: [ "./js/**" ],
      exclude: "node_modules/**",
      babelHelpers: "bundled",
    }),
    css({
      output: 'docs/css/bundle.css'
    }) 
  ]
}