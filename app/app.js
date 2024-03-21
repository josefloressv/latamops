require('newrelic');
const express = require("express");
const app = express();

app.get("/", (req, res) => {  
  res.status(200).send("OK");
});

app.get("/app01", (req, res) => {  
  console.log(getTimestampLog() + " procesando peticion...");
  res.send("Hola Comunidad!");
});

app.get("/app01/cncf", (req, res) => {  
  res.send("Hola Comunidad CNCF!");
});

app.get("/app01/jobsity", (req, res) => {  
  res.send("Hello Jobsity!");
});

app.get("/app01/health", (req, res) => {
  res.send("UP");
});

app.get("/app01/dashboard", (req, res) => {  
  console.log(getTimestampLog() + " trying to access dashboard without login...");
  res.status(401).send("Unauthorized");
});

app.listen(3000, () => {
  console.log(getTimestampLog() +" App listening on port 3000!");
});

function getTimestampLog() {
  return new Date((dt = new Date()).getTime() - dt.getTimezoneOffset() * 60000).toISOString().replace(/(.*)T(.*)\..*/,'$1 $2');
}