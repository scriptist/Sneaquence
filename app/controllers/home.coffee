express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Sequence  = mongoose.model 'Sequence'

module.exports = (app) ->
	app.use '/', router

	router.get '/', (req, res, next) ->
		Sequence.find (err, sequences) ->
			return next(err) if err

			res.render 'index',
				title: 'Generator-Express MVC'
				sequences: sequences
