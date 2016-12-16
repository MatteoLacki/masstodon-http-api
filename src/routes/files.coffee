# _ = require 'lodash'
# async = require 'async'
path = require 'path'
fs = require 'fs-extra'

Busboy = require 'busboy'


TMP_DIR = path.resolve path.join 'tmp'
console.log 'TMP: ', TMP_DIR

fs.ensureDir TMP_DIR, (err) ->
	if err?
		console.log "Fail to dir: ", err
		process.exit()
	else
		console.log "Ensured dir: ", TMP_DIR


module.exports =
	save: (req, res, next) ->
		if req.method == 'POST'
			busboy = new Busboy headers: req.headers

			busboy.on 'file', (fieldname, file, filename, encoding, mimetype) ->
				saveTo = path.join TMP_DIR, path.basename fieldname
				console.log 'saving to: ', saveTo
				file.pipe fs.createWriteStream saveTo

			busboy.on 'finish', ->
				res.writeHead 200, 'Connection': 'close'
				res.end "That's all folks!"

			req.pipe busboy
		else
			res.writeHead 404
			res.end()
