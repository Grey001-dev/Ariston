import mongoose from "mongoose";

const rankingSchema=new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    XP: {
        type: Number
    },
    tier: {
        type: Number
    }
})
const Ranking = mongoose.model("Ranking", rankingSchema);
export default Ranking;