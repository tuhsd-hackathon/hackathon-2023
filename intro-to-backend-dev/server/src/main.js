const express = require('express');
// posted payload
const bodyParser = require('body-parser')
// external api
const http = require('http')

const app = express();
// posted payload
app.use(bodyParser.json())

//
// Hello World Endpoint
//
app.get('/', (_req, res) => {
  res.send('Hello World')
})

// Utility Method to get random int in range
function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min) + min)
}

//
// Weather Endpoints
//

// Fake Weather response
function getWeather(city, state) {
  return {
    city,
    state,
    temp: getRandomInt(-10, 110),
  }
}

//
// Weather Third Party Service
//
// https://www.weatherapi.com/
function getWeatherFromApi(city, state) {
  // API key
  // WARNING: you shouldn't ever really commit an api key to a code repo like this.
  // I am doing so here only as an example
  return new Promise((resolve, reject) => {
    http.get(`http://api.weatherapi.com/v1/current.json?key=b5730c346cd74098b23184943230104&q=${city}, ${state}&aqi=no`, (resp) => {
      if (resp.statusCode === 200) {
        resp.on("data", function(chunk) {
          data = JSON.parse(chunk)
          resolve(data)
        });
      }
    })
  })
 }

// NOTE: query string params
app.get('/weather', (req, res) => {
  console.log('weather request received with query string: ', req.query)
  // res.send(req.query)
  res.send(getWeather(req.query.city, req.query.state))
})

// NOTE: posted payload
app.post('/weather', (req, res) => {
  let data = req.body
  console.log('city: ', req.body.city)
  console.log('state:', req.body.state)
  // res.send(req.body)
  res.send(getWeather(req.body.city, req.body.state))
})

// NOTE: path params
app.get('/weather/:state/:city', async (req, res) => {
  console.log(`received weather request for ${req.params.city}, ${req.params.state}`)
  const data = await getWeatherFromApi(req.params.city, req.params.state)
  res.send(data)
  // res.send(`received weather request for ${req.params.city}, ${req.params.state}`)
  // res.send(getWeather(req.params.city, req.params.state))
})


//
// Start server and listen
//
app.listen(8080, () => {
  console.log('listening on port 8080...')
})
