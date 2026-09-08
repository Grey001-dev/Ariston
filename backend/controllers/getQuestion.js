import { fetchQuestionsFunc } from "../lib/questions.js";

export const fetchQuestions=async (req,res)=>{
    const {subjects,difficulty,amount,topic,year}=req.body;
    try {
        if(!amount){
            return res.status(401).json("Invalid credentials,please input fields specified")
        }
        const totalQuestions=await fetchQuestionsFunc(subjects,difficulty,amount);
        return res.status(200).json({message:"Successful",totalQuestions:totalQuestions})
    } catch (error) {
        console.error(error);
        return res.status(500).json({message:"Internal server error"});
    }
}