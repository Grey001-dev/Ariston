import dotenv from 'dotenv';
dotenv.config()
import express from 'express';
import cors from 'cors'
import connectDB from './config/db.js';
import authRoutes from './routes/authroutes.js';
import test from './routes/testingroutes.js';
import dns from 'dns';
dns.setServers(['8.8.8.8', '1.1.1.1']);
const app=express();
const PORT=process.env.PORT || 80

app.use(express.json());
app.use(express.urlencoded({ extended:true }));
app.use("/auth/routes",authRoutes);
app.use("/api/questions",test);

connectDB();
app.listen(PORT,()=>{
    console.log("Server dey run ejeh")
})