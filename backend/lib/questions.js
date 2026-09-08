import Questions from "../model/questionSchema.js";
function shuffle(array){
    return [...array].sort(()=>Math.random()-0.5)
}

export async function fetchQuestionsFromDb(subjects,difficulty,amount,topic,year){
    try {
        const match = {};
        if (subjects) match.subject = { $in: Array.isArray(subjects) ? subjects : [subjects] };
        if (difficulty) match.difficulty = difficulty;
        if(topic) match.difficulty=topic;
        if(year) match.year=year;

        const questions = await Questions.aggregate([
            { $match: match },
            { $sample: { size: amount } }
        ]);
        return questions;
    } catch (error) {
        console.error(error);
        throw new Error("Failed to fetch questions from DB");
    }
}

export async function fetchQuestionsFunc(subjects,difficulty,amount){
    let rawQuestions=[];
    if(!subjects|| subjects.length==0){
        rawQuestions=await fetchQuestionsFromDb(null,difficulty,amount)

    }else{

    
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
    }));

}