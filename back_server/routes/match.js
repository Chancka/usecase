const express = require("express");
const router = express.Router();

const Match = require("../models/match");

router.use((req, res, next) => {
  res.set("Access-Control-Allow-Origin", "*");
  res.set(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  res.set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
  res.set("Access-Control-Allow-Credentials", true);
  next();
});

router.route("/:id").get(async (req, res) => {
  const match = await Match.findById(req.params.id);
  res.status(200);
  res.send(match);
});

module.exports = router;
