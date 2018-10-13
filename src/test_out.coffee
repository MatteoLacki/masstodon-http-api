_ = require 'lodash'
path = require 'path'
fs = require('fs')
gcs = require './gcs'

myBucket = gcs.defaultBucket
job =
	out: path.resolve './.tmp/output'
	ownerID: 'matteo_user_id2'
	id: 'matteo_test_job_id'

jobFolder = path.resolve job.out, job.id

fs.readdir jobFolder, (err, files) ->
	files.forEach (f) ->

		cloudFile = myBucket.file "results/#{job.ownerID}/#{job.id}/#{f}"
		fs.createReadStream(path.resolve jobFolder, f)
			.pipe cloudFile.createWriteStream
				gzip: true
				resumable: false
				metadata:
					contentType: 'text/html'
			.on 'error', -> console.log 'some upload err'
			.on 'finish', ->
				console.log "Upload for: #{path.resolve jobFolder, f} done"

		# fs.createReadStream('/Users/stephen/site/index.html')
  # .pipe(file.createWriteStream({ gzip: true }))
  # .on('error', function(err) {})
  # .on('finish', function() {
  #   // The file upload is complete.
  # });




# matteo.stdout.on 'data', (data) ->
# 	console.log "out #{data}"

# matteo.stderr.on 'data', (data) ->
# 	console.log "--errLout #{data}"

# matteo.on 'close', (code) ->
# 	console.log 'end: ', code
