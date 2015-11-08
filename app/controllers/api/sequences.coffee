express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Sequence  = mongoose.model 'Sequence'

module.exports = (app) ->
	app.use '/api/sequences', router

	# Create
	router.post '/', (req, res, next) ->
		sequence = new Sequence
			name: req.body.name
			music: ' ' # TODO: read music from blob
			length: 0 # TODO:

		sequence.save (err) ->
			return errorHandler res, err if err

			res.json
				sequence: sequence

	# Read all
	router.get '/', (req, res, next) ->
		Sequence.find (err, sequences) ->
			return errorHandler res, err if err

			res.json
				sequences: sequences

	# Read one
	router.get '/:id', (req, res, next) ->
		Sequence.findById req.params.id, (err, sequence) ->
			return errorHandler res, err if err
			return errorHandler res, 'No sequence found' if !sequence

			res.json
				sequence: sequence

	# Update
	router.put '/:id', (req, res, next) ->
		$set = {}
		$set.name = req.body.name if 'name' of req.body

		Sequence.findByIdAndUpdate req.params.id, {$set: $set}, {new: true}, (err, sequence) ->
			return errorHandler res, err if err
			return errorHandler res, 'No sequence found' if !sequence

			res.json
				sequence: sequence

	# Delete
	router.delete '/:id', (req, res, next) ->
		Sequence.findByIdAndRemove req.params.id, (err, sequence) ->
			return errorHandler res, err if err
			return errorHandler res, 'No sequence found' if !sequence

			res.json
				sequence: sequence


	errorHandler = (res, error) ->
		res.json
			error: if typeof error == 'string' then true else error.name
			message: if typeof error == 'string' then error else error.message
