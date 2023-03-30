
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
})