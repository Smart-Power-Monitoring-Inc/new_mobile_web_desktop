const express = require('express')
const app = express()
require('dotenv').config()


const PORT = 3000 || process.env.PORT

app.listen(PORT, ()=>{
    console.info("Server running on ",PORT)
})
/*
* I plan on creating my own local database that stores in json
* a new json file schould be created each new day.
* Reading sent to the server will be stored in days
*
* */