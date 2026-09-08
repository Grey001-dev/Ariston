import dotenv from 'dotenv';
dotenv.config()
import express from 'express';
import cors from 'cors'
import { Server } from 'socket.io';
import http from "http";
import connectDB from './config/db.js';
import authRoutes from './routes/authroutes.js';
import { Question } from './routes/question.js';
import { socketHandler } from './config/socketHandler.js';
import dns from 'dns';
dns.setServers(['8.8.8.8', '1.1.1.1']);
const app=express();
const PORT=process.env.PORT || 80
const httpServer=http.createServer(app);
socketHandler(httpServer);
app.use(cors({
    origin: "*",
}))

app.use(express.json());
app.use(express.urlencoded({ extended:true }));
app.use("/auth/routes",authRoutes);
app.use("/api/questions",Question)

connectDB();

httpServer.listen(PORT,()=>{
    console.log(`Server on port ${PORT}`)
})