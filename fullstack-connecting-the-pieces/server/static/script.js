// Element References
const result_city = document.querySelector(".cityName")
const result_c = document.querySelector(".celsius")
const result_f = document.querySelector(".fahrenheit")
// Select text input
const textInput = document.getElementById('city');
const text2Input = document.getElementById('state');
// Store the value of the input in a variable
let cityName = textInput.value;
let stateName = text2Input.value;
// When an input event is triggered update cityName and stateName
textInput.addEventListener('input', function(e) 
{
  cityName = e.target.value;
})

text2Input.addEventListener('input', function(e) 
{
  stateName = e.target.value;
})

// Select our form
const form = document.querySelector('form');
// When form is submitted print state and city to the browser console
form.addEventListener('submit', function(e) {
  // prevent form default behavior
  e.preventDefault();

  // print input value
  console.log(cityName);
  console.log(stateName);

  // clear input
  textInput.value = '';
  text2Input.value = '';

  // request weather data
  const reqString = "/weather/" +  stateName + "/" + cityName

  fetch(reqString)
    .then((response) => {
      response.json().then((data) => {
        console.log(data)

        result_city.textContent = data.location.name + ", " + data.location.region
        result_f.textContent = data.current.temp_f + " F"
        result_c.textContent = data.current.temp_c + " C"
      })
    })
    .catch((response) => {
      alert("ERROR!")
    })
})