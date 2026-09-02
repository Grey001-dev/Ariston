import express from 'express'
import { handleRegister,handleLogin,googleAuth } from '../controllers/auth.js';

const authRoutes=express.Router();
authRoutes.post("/register",handleRegister);
authRoutes.post("/login",handleLogin);
authRoutes.post("/google",googleAuth);

export default authRoutes