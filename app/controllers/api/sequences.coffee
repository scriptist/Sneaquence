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
			music: 'req.body.music'
			length: 0 # TODO:

		sequence.save (err) ->
			return errorHandler res, err if err

			ret = sequence.toObject()
			delete ret.music

			res.json
				sequence: ret

	# Read all
	router.get '/', (req, res, next) ->
		Sequence
			.find()
			.select 'name approved length'
			.exec (err, sequences) ->
				return errorHandler res, err if err

				res.json
					sequences: sequences

	# Read one
	router.get '/:id', (req, res, next) ->
		Sequence
			.findById req.params.id
			.exec (err, sequence) ->
				return errorHandler res, err if err
				return errorHandler res, 'No sequence found' if !sequence

				res.json
					sequence: sequence

	# Update
	router.put '/:id', (req, res, next) ->
		$set = {}
		$set.name = req.body.name if 'name' of req.body

		Sequence
			.findByIdAndUpdate req.params.id, {$set: $set}, {new: true}
			.select 'name approved length'
			.exec (err, sequence) ->
				return errorHandler res, err if err
				return errorHandler res, 'No sequence found' if !sequence

				res.json
					sequence: sequence

	# Delete
	router.delete '/:id', (req, res, next) ->
		Sequence
			.findByIdAndRemove req.params.id
			.select 'name approved length'
			.exec (err, sequence) ->
				return errorHandler res, err if err
				return errorHandler res, 'No sequence found' if !sequence

				res.json
					sequence: sequence


	errorHandler = (res, error) ->
		res.json
			error: if typeof error == 'string' then true else error.name
			message: if typeof error == 'string' then error else error.message
