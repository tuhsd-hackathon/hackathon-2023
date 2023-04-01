const express = require("express");

const app = express();

app.get('/', (_req, res) => {
  res.send("Hello World")
})

app.get('/weather/:state/:city', (req, res) => {
  console.log(`received weather request for ${req.params.city}, ${req.params.state}`)
  res.send(`received weather request for ${req.params.city}, ${req.params.state}`)
})

app.listen(8080, () => {
  console.log("listening on port 8080...")
})
