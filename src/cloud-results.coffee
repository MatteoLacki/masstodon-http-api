

module.exports =

	upload: (bucket, conf) ->

		new Promise (resolve, reject) ->

			setTimeout ->
				resolve 'yay'
			, 1000
