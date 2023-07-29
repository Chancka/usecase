const mongoose = require("mongoose");
const matchSchema = require("./match").schema;

const historySchema = new mongoose.Schema({
  match: {
    type: Array,
    default: [matchSchema],
    required: true,
  },
});

const History = mongoose.model("History", historySchema);

module.exports = History;
