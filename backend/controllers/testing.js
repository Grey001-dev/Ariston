import Questions from "../model/questionSchema.js";

export const handleQuestions=async(req,res)=>{
    const {year,solution,questionText,options,correctOption,subject}=req.body;
    try {
        const Question=Questions.create({year,solution,questionText,options,correctOption,subject});
        return res.status(200).json({message:"Question created succesfully"});
    } catch (error) {
        console.error(error)
        return res.status(500).json({message:"Server error"},error)
    }
}