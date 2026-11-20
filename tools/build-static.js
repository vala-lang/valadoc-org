import { cpSync, globSync, mkdirSync } from 'node:fs'
import { basename, join } from 'node:path'

const out = 'valadoc.org'

const copy = (pattern, dest) => {
  mkdirSync(join(out, dest), { recursive: true })
  for (const file of globSync(pattern)) {
    cpSync(file, join(out, dest, basename(file)))
  }
}

copy('data/*.php', '.')
copy('data/scripts/*.js', 'scripts')
copy('data/images/*', 'images')

const fonts = 'node_modules/@fontsource'
copy(`${fonts}/open-sans/files/open-sans-latin-{300,400}-normal.woff2`, 'fonts')
copy(`${fonts}/noto-serif/files/noto-serif-latin-400-normal.woff2`, 'fonts')
copy(`${fonts}/roboto-mono/files/roboto-mono-latin-{400,500,700}-normal.woff2`, 'fonts')
copy(`${fonts}/roboto-mono/files/roboto-mono-latin-400-italic.woff2`, 'fonts')
