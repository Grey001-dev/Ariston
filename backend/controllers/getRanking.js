import Ranking from "../model/rankingSchema";

export const getRanking=async(req,res)=>{
    try {
        const topRankings = await Ranking.find()
    .sort({ XP: -1 })
    .limit(20)
    .populate("user");

    return res.status(200).json(topRankings);
    } catch (error) {
        console.error(error);
        return res.status(400).json({message:"Error caught fetching rankings"})
    }
}