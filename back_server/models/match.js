const mongoose = require("mongoose");

const matchSchema = mongoose.Schema({
  resultOfMatch: {
    type: String,
    required: true,
  },
  typeOfMatch: {
    type: String,
    required: true,
  },
  dateOfMatch: {
    type: String,
    required: true,
  },
  imageOfCharacter: {
    type: String,
    required: true,
  },
  kda: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    required: true,
  },
  comment: {
    type: String,
    required: true,
  },
});

const Match = mongoose.model("Match", matchSchema);

module.exports = Match;
