const app = require('./app');
const db = require('./config/db');
const userModel = require('./model/user_model');
const coffeeModel = require('./model/coffee_model');


const port = 3000;

app.get('/',(req,res)=>{
    res.send('fuck this shit')
})
app.listen(port,()=>{console.log('server is running')});