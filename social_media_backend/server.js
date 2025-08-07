const express = require("express");
const connectDB = require('./config/db');
const route = require('./routes/route');
const postRouter = require('./routes/postRoute')

const PORT = 5008;

const app = express(); 
connectDB();
app.use(express.json());
app.use("/api/auth", route);
app.use("/api/posts", postRouter);

 
app.listen(PORT, "0.0.0.0", function() {
    console.log(`Server is running on port ${PORT}`);
});