import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import User from "../model/userSchema.js";
import {OAuth2Client} from "google-auth-library";
import dotenv from "dotenv";
dotenv.config();
const client=new OAuth2Client(process.env.GOOGLE_WEB_CLIENT_ID);


export const handleRegister=async(req,res)=>{
    const {name,password,email}=req.body;
    try {
    if(!name || !email || !password){
    return res.status(400).json({message:'Invalid credentials'});
    }

    const existingEmail=await User.findOne({email});
    if(existingEmail){
        return res.status(400).json({message:"Email already exists."});
    }
    const existingUsername=await User.findOne({name});
    if(existingUsername){
        return res.status(400).json({message:'Username already exists'});
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword=await bcrypt.hash(password,salt);
    const user=await User.create({name,email,password:hashedPassword});
    const token=jwt.sign({id:user._id},process.env.JWT_SECRET,{expiresIn:"20d"})
    return res.status(200).json({
        token,
        message:"Account successfully created",
        username:user.name
    })  
    } catch (error) {
        console.error(error)
        return res.status(500).json({message:'Authentication error',error})
    }
}

export const handleLogin=async(req,res)=>{
    const {email,password}=req.body;
    try {
        if(!email || !password){
            return res.status(400).json({message:"Invalid credentials"});
        }
        const existingEmail=await User.findOne({email})
        if(!existingEmail){
            return res.status(404).json({message:"Email not found"});
        }
        const confirmPassword=await bcrypt.compare(password,existingEmail.password);
        if(!confirmPassword){
            return res.status(400).json({message:"Wrong password"});
        }
        const token=jwt.sign({id:existingEmail._id},process.env.JWT_SECRET,{expiresIn:"20d"});
        return res.status(200).json({
            message:"Login successful",
            token,
            username:existingEmail.name
        })
    } catch (error) {
        return res.status(500).json({message:'Authentication error',error})
    }

}

export const googleAuth=async(req,res)=>{
    const { idToken } = req.body;
    try {
        if (!idToken) {
            return res.status(400).json({ message: "idToken required" });
        }

        const ticket = await client.verifyIdToken({
            idToken,
            audience: process.env.GOOGLE_WEB_CLIENT_ID,
        });
        const { email, name, sub } = ticket.getPayload();
        let user = await User.findOne({ email });
        if (!user) {
            user = await User.create({ name, email});
        }
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "20d" });
        return res.status(200).json({
            message: "Login successful",
            token,
            username:user.name
        });
    } catch (error) {
        console.error(error);
        return res.status(401).json({ message: "Invalid Google token", error });
    }
}