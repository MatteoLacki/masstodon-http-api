_ = require 'lodash'
axios = require 'axios'
path = require 'path'
mkdirp = require 'mkdirp'
fs = require 'fs-extra'

gcs = require './gcs'
firebase = require './firebase'
massRunner = require './masstodon-worker'
cResults = require './cloud-results'

workDir = path.resolve process.cwd(), '.tmp'
myBucket = gcs.defaultBucket


# Ensure dirs
mkdirp workDir, (e) ->
	console.log 'Ensured', workDir

# --- Runner
jobs = firebase.database().ref 'jobs'
files = firebase.database().ref 'files'



jobs.on 'value', (snap) ->
	allJobs = snap.val()

	_.forEach allJobs, (job, k) ->

		jobDir = path.resolve workDir, 'input', k

		pathConf =
			spectr: path.resolve jobDir, 'spectr'
			conf:   path.resolve jobDir, 'config.json'
			out:    '-o' + path.resolve workDir, 'output', k

		console.log pathConf


		# Ensure folder and download input file
		mkdirp jobDir, (e) ->
			console.log 'job dir ensured: ', jobDir

			# handle File downloads
			_.forEach job.file, (v, k) ->
				files.child(k).once('value').then (snap) ->
					file = snap.val()

					myBucket.file("spectro/#{job.owner}/#{file.baseName}").download destination: pathConf.spectr, (err) ->

						conf = _.cloneDeep job.config
						delete conf.user
						delete conf.configName
						delete conf.key

						fs.outputJson(pathConf.conf, conf).then ->
							console.log 'file saved'


							massRunner pathConf, (err, res) ->
								console.log 'err, res', err, res
							console.log 'dupa'


						# Handle config



			# myBucket.getFiles (err, files) ->
			# 	console.log 'DUPPA: ', err,  files


			jobs.child(k).child('processed').set(true).then (e) ->
				console.log 'UPDATED JOB'
