const express = require('express');
const body_parser = require('body-parser');
const userRouter = require('./routes/user_route');
const coffeRouter = require('./routes/coffee_route');
const cartRouter = require('./routes/cartRoutes');
const addRouter = require('./routes/addRoute')
const orderRouter = require('./routes/orderRoute')
const app = express();

app.use(body_parser.json());
app.use('/',userRouter);
app.use('/',coffeRouter);
app.use(body_parser.json());
app.use('/', cartRouter);
app.use(body_parser.json());
app.use('/', addRouter);
app.use('/', orderRouter);

module.exports = app;