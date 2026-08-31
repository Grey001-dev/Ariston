import express from 'express'
import { handleRegister,handleLogin } from '../controllers/auth.js';
const authRoutes=express.Router();
authRoutes.post("/register",handleRegister);
authRoutes.post("/login",handleLogin);
export default authRoutes