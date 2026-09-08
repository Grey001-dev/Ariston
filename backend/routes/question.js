import express from 'express';
import { fetchQuestions } from '../controllers/getQuestion.js';
export const Question=express.Router();
Question.get("/",fetchQuestions);