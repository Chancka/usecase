const express = require("express");
const router = express.Router();

const History = require("../models/history");
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

router
  .route("/")
  .get(async (req, res) => {
    const history = await History.find();
    res.status(200);
    res.send(history);
  })
  .post(async (req, res) => {
    const match = await Match.create(req.body);
    const history = await History.create({ match: match });
    res.status(201);
    res.send(history);
  });

module.exports = router;
