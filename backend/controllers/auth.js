import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import User from "../model/schema.js";
import dotenv from "dotenv";
dotenv.config();

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
            token
        })
    } catch (error) {
        return res.status(500).json({message:'Authentication error',error})
    }

}