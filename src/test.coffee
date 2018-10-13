_ = require 'lodash'
axios = require 'axios'
console.log 'dupa'
{ spawn } = require 'child_process'

path = require 'path'

job =
	spec: path.resolve './.tmp/input/a11', 'spectr.txt'
	conf: path.resolve './.tmp/input/a11', 'config.txt'
	out: '-o ' + path.resolve './.tmp/output'

console.log job

matteo = spawn 'masstodon', [
	job.spec
	job.conf
	job.out
]


# matteo.stdout.on 'data', (data) ->
# 	console.log "out #{data}"

# matteo.stderr.on 'data', (data) ->
# 	console.log "--errLout #{data}"

# matteo.on 'close', (code) ->
# 	console.log 'end: ', code
