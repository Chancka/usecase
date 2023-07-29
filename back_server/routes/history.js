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

function fetchImageFromAPI(nameOfCharacter) {
  const url = "https://valorant-api.com/v1/agents/";
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      data.data.forEach((agent) => {
        if (agent.displayName === nameOfCharacter) {
          return agent.displayIcon;
        }
      });
    });
}

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

router
  .route("/")
  .get(async (req, res) => {
    const history = await Match.find();
    res.status(200);
    res.send(history);
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
    });
    await match.save();
    res.status(201);
    res.send(match);
  });

module.exports = router;
