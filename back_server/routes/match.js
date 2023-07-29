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

router
  .route("/:id")
  .get(async (req, res) => {
    const match = await Match.findById(req.params.id);
    res.status(200);
    res.send(match);
  })
  .delete(async (req, res) => {
    try {
      const match = await Match.findById(req.params.id);
      await match.deleteOne({ _id: req.params.id });
      res.status(204);
      res.send();
    } catch (error) {
      console.error(error);
      res.status(404);
      res.send("Match not found");
    }
  })
  .put(async (req, res) => {
    try {
      const match = await Match.findById(req.params.id);
      if (req.body.resultOfMatch) {
        match.resultOfMatch = req.body.resultOfMatch;
      }
      if (req.body.typeOfMatch) {
        match.typeOfMatch = req.body.typeOfMatch;
      }
      if (req.body.dateOfMatch) {
        match.dateOfMatch = req.body.dateOfMatch;
      }
      if (req.body.imageOfCharacter) {
        match.imageOfCharacter = req.body.imageOfCharacter;
      }
      if (req.body.kda) {
        match.kda = req.body.kda;
      }
      if (req.body.role) {
        match.role = req.body.role;
      }
      if (req.body.comment) {
        match.comment = req.body.comment;
      }
      await match.save();
      res.status(200);
      res.send(match);
    } catch (error) {
      console.error(error);
      res.status(404);
      res.send("Match not found");
    }
  });

module.exports = router;
