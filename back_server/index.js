const express = require("express");
const app = express();
const port = 4242;
const mongoose = require("mongoose");
const history = require("./routes/history");
const match = require("./routes/match");

app.use(express.json());
app.use("/history", history);
app.use("/match", match);

mongoose.set("strictQuery", false);
mongoose
  .connect(
    "mongodb+srv://chancka:9E9PaRfkDto9vNqw@cluster0.hfw40cf.mongodb.net/my_tracker?retryWrites=true&w=majority"
  )
  .then(() => {
    app.listen(port, () => console.log(`Server listening on port ${port}`));
    // fetchImageFromAPI();
    console.log("Connected to MongoDB");
  })
  .catch((err) => console.log("Failed to connect to MongoDB", err));
