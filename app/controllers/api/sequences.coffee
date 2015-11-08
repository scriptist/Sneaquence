express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Sequence  = mongoose.model 'Sequence'

module.exports = (app) ->
	app.use '/api/sequences', router

	# Create
	router.post '/', (req, res, next) ->
		res.json
			message: 'Not implemented'

	# Read
	router.get '/', (req, res, next) ->
		Sequence.find (err, sequences) ->
			return errorHandler res, err if err

			res.json
				sequences: sequences

	# Update
	router.put '/:id', (req, res, next) ->
		res.json
			message: 'Not implemented'

	# Delete
	router.delete '/:id', (req, res, next) ->
		res.json
			message: 'Not implemented'


	errorHandler = (res, error) ->
		res.json
			error: error.name
			message: error.message
