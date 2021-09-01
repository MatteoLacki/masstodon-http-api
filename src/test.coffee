_ = require 'lodash'
axios = require 'axios'
{ spawn } = require 'child_process'
path = require 'path'


# Config
job =
	spec: path.resolve './.tmp/input/a11', 'spectr.txt'
	conf: path.resolve './.tmp/input/a11', 'config.txt'
	out: '-o ' + path.resolve './.tmp/output'

console.log 'JOB Descr: '
console.log job
console.log "\n\n"

# RUN TEST
lol = spawn 'ls', [
	'-l'
]
console.log 'LS Test: '
lol.stdout.on 'data', (data) -> console.log "LS: #{data}"


# RUN MAsstodon
# console.log "\n\n"
# matteo = spawn 'masstodon', [
# 	job.spec
# 	job.conf
# 	job.out
# ]

# matteo.stdout.on 'data', (data) ->
# 	console.log "out #{data}"

# matteo.stderr.on 'data', (data) ->
# 	console.log "--errLout #{data}"

# matteo.on 'close', (code) ->
# 	console.log 'end: ', code
