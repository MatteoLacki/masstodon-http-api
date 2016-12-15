require 'cache-require-paths'
express = require 'express'


app = express()
# app.use require('cors')()


# bodyParser = require 'body-parser'
# app.use bodyParser.urlencoded extended: false
# app.use(bodyParser.json())

# methodOverride = require('method-override')
# app.use(methodOverride('X-HTTP-Method'))
# app.use(methodOverride('X-HTTP-Method-Override'))
# app.use(methodOverride('X-Method-Override'))

app.use require('cookie-parser')('polygoncast')
app.use require('compression')()

# development only
# app.use require('errorhandler')()  if "development" is app.get("env")

mainRouter = express.Router()
app.use '/api', mainRouter
app.get '/', (req, res) ->
	res
		.status 200
		.send 'MassTodon API is online!'



# Core deps
# require './config.coffee'


module.exports = exports = app



server = app.listen 80, ->
	host = server.address().address
	port = server.address().port
	console.log 'Masstodn app listening at http://%s:%s with an enviroment %s', host, port, app.get 'env'
