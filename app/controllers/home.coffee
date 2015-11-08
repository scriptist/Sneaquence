express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
Sequence  = mongoose.model 'Sequence'

module.exports = (app) ->
	app.use '/', router

	router.get '/', (req, res, next) ->
		res.render 'index'
