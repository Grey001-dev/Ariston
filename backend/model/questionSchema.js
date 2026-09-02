import mongoose from "mongoose";

const questionSchema = new mongoose.Schema({
    questionText: {
        type: String,
        required: true,
    },

    questionMedia: {
        type: String,
        default: "",
    },

    options: [
        {
            label: {
                type: String,
                enum: ["A", "B", "C", "D", "E"],
                required: true,
            },
            text: {
                type: String,
                required: true,
            },
            media: {
                type: String,
                default: "",
            },
        },
    ],

    correctOption: {
        type: String,
        enum: ["A", "B", "C", "D", "E"],
        required: true,
    },

    solution: {
        type: String,
        default: "",
    },

    solutionMedia: {
    type: String,
    default: "",
    
},

    subject:{
        type:String,
        required:true
    },

    topic:{
        type:String,
        default:""
    },

    difficulty:{
        type:String,
        default:''
    },

    year: {
        type: String,
        required: true,
    },
});
const Questions=mongoose.model("Question", questionSchema);
export default Questions;