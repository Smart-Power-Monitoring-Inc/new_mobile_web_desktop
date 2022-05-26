const router = require('express').Router()
const fs = require('fs')

router.get("/user/:uid/",(req,res)=>{
    // Navigate
try{
    process.chdir("../data/user") // change directory to the data directory.
    // this is where all the app data is stored
    let fileExists = fs.existsSync(`${req.params.uid}.json   `);
    if(fileExists){
        fs.readFile(`${req.params.uid}.json`, 'utf8', function(err, data){
            let parsedUserData = JSON.parse(data)
            // Display the file content
            console.table(data);
            return res.json({
                found:true,
                data:parsedUserData
            })
        });
    }else{
        return res.status(404).json({
            found:false,
            data:null
        })
    }

}catch (e) {
    console.error(e,"An error occured")
}
})


router.post("user/create",(req,res)=>{
    // Use this endpoint to create a user
    const body = req.body
    // These are the keys expected in the body object
    // name,email,phone,password
    let expectedKeys = ["name","phone","email","password"]
    for(let key in expectedKeys){
        if(!Object.keys(body).includes(key)){

            return res.statusCode(404).json({
                error:true,
                message:key + " was expected but was not present"
            })
        }

    }

    // if all the keys are present, create the user

})
module.exports.userRoute = router;