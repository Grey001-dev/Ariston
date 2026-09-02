import express from 'express';
import { handleQuestions } from '../controllers/testing.js';
const test=express.Router();
test.post("/",handleQuestions);
export default test;