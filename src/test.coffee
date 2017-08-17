_ = require 'lodash'
axios = require 'axios'

{ spawn } = require 'child_process'

path = require 'path'

job =
	spec: path.resolve './.tmp/input', 'spectr.txt'
	conf: path.resolve './.tmp/input', 'config.txt'
	out: '-o' + path.resolve './.tmp/output'

matteo = spawn 'masstodon', [
	job.spec
	job.conf
	job.out
]


matteo.stdout.on 'data', (data) ->
	console.log "out #{data}"

matteo.stderr.on 'data', (data) ->
	console.log "--errLout #{data}"

matteo.on 'close', (code) ->
	console.log 'end: ', code
