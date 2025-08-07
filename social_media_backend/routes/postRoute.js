const express = require('express');
const {createPost, getAllPost} = require('../controllers/postControllers');
const { protect } = require('../middleware/middleware');

const postRouter = express.Router();

//only authencated user can create 
postRouter.post('/', protect, createPost);
postRouter.get('/', protect, getAllPost);


module.exports = postRouter;