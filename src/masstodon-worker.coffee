_ = require 'lodash'
axios = require 'axios'

{ spawn } = require 'child_process'

path = require 'path'

# job =
# 	spec: path.resolve './.tmp/input', 'spectr.txt'
# 	conf: path.resolve './.tmp/input', 'config.txt'
# 	out: '-o' + path.resolve './.tmp/output'


module.exports = (conf, cb) ->
	matteo = spawn 'json2masstodon', [
		conf.conf
		'--plot'
	]

	matteo.stdout.on 'data', (data) ->
		console.log "out #{data}"

	matteo.stderr.on 'data', (data) ->
		console.log "--errLout #{data}"
		cb data

	matteo.on 'close', (code) ->
		console.log 'end: ', code
		cb null
