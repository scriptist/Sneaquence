mongoose = require 'mongoose'
Schema   = mongoose.Schema

InstructionSchema = new Schema(
	startTime:
		type: Number
		required: true

	stopTime:
		type: Number
		required: true

	channel:
		type: Number
		required: true
		validate: (val) -> val == parseInt val, 10

	instruction:
		type: String
		default: 'on'
		enum: ['on', 'twinkle']
)

AutosaveSchema = new Schema(
	date:
		type: Date
		default: Date.now

	instructions: [InstructionSchema]
)

SequenceSchema = new Schema(
	name:
		type: String
		required: true

	approved:
		type: Boolean
		default: false

	music:
		type: String
		required: true

	instructions: [InstructionSchema]

	autosaves: [AutosaveSchema]
)

SequenceSchema.virtual('date')
	.get (-> this._id.getTimestamp())

mongoose.model 'Sequence', SequenceSchema
