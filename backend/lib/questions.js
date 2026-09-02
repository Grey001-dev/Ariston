import Questions from "../model/questionSchema";
function shuffle(array){
    return [...array].sort(()=>Math.random()-0.5)
}

export async function fetchQuestionsFromDb(subjects,difficulty,amount){
    try {
        const questions = await Questions.aggregate([
        { $match: { subject: subjects, difficulty: difficulty } }, 
        { $sample: { size: amount } }
        ])
        return questions;
    } catch (error) {
        console.error(error);
        throw new Error("Failed to fetch questions from DB");
    }
}

export async function fetchQuestions(subjects,difficulty,amount){
    let rawQuestions=[];
    let questionPerSubject= Math.floor(amount/subjects.length);
    let remainder=amount % subjects.length;
    for(let i=0;i<subjects.length;i++){
        if(i==0){
            let results=await fetchQuestionsFromDb(subjects[i],difficulty,questionPerSubject + remainder)
            rawQuestions = rawQuestions.concat(results)
        }else{
            let results=await fetchQuestionsFromDb(subjects[i],difficulty,questionPerSubject)
            rawQuestions = rawQuestions.concat(results)
        }
    }
    rawQuestions=shuffle(rawQuestions);
    return rawQuestions.map((q,index)=>({
        id:q._id || `q${index}`,
        questionText: q.questionText,
        subject:q.subject,
        difficulty:q.difficulty,
        correctOption:q.correctOption,
        options:shuffle([...q.options]),
        year:q.year,
        topic:q.topic,
    }))
}