const express = require("express");
const router = express.Router();

const Match = require("../models/match");

// middleware to allow CORS
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

// route to match by id
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
      if (!match) {
        res.status(404);
        res.send("Match not found");
        return;
      }
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

// fetch image of character from API
async function fetchImageFromAPI(nameOfCharacter) {
  const url = "https://valorant-api.com/v1/agents/";
  try {
    const response = await fetch(url);
    const data = await response.json();
    const agent = data.data.find(
      (agent) => agent.displayName.toLowerCase() === nameOfCharacter
    );
    if (agent) {
      return agent.displayIcon;
    } else {
      return null;
    }
  } catch (error) {
    console.error(
      "Erreur lors de la récupération des données depuis l'API",
      error
    );
    return null;
  }
}

async function fetchRoleFromAPI(nameOfCharacter) {
  const url = "https://valorant-api.com/v1/agents/";
  try {
    const response = await fetch(url);
    const data = await response.json();
    const agent = data.data.find(
      (agent) => agent.displayName.toLowerCase() === nameOfCharacter
    );
    if (agent) {
      return agent.role.displayName;
    } else {
      return null;
    }
  } catch (error) {
    console.error(
      "Erreur lors de la récupération des données depuis l'API",
      error
    );
    return null;
  }
}

// route to all matches
router
  .route("/")
  .get(async (req, res) => {
    const matches = await Match.find();
    res.status(200);
    res.send(matches);
  })
  .post(async (req, res) => {
    const imageOfCharacter = await fetchImageFromAPI(req.body.imageOfCharacter);
    const role = await fetchRoleFromAPI(req.body.imageOfCharacter);
    const match = new Match({
      resultOfMatch: req.body.resultOfMatch,
      typeOfMatch: req.body.typeOfMatch,
      dateOfMatch: req.body.dateOfMatch.slice(0, 10),
      imageOfCharacter: imageOfCharacter,
      kda: req.body.kda,
      role: role,
      comment: req.body.comment,
      nameOfCharacter: req.body.imageOfCharacter,
    });
    await match.save();
    res.status(201);
    res.send(match);
  });

module.exports = router;
