import express from "express";
import { getRanking } from "../controllers/getRanking";
export const rankingRouter=express.Router();
rankingRouter.get("/",getRanking);