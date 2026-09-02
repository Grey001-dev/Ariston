import User from "../model/schema.js";
import Friendship from "../model/friendSchema.js";

const sendRequest = async (req, res) => {
    try{
        const { requesterId, recipientId } = req.body;

        const requester = await User.findOne ({_id: requesterId });
        const recipient = await User.findOne({ _id: recipientId });

        if (!requester || !recipient) {
            return res.status(400).json({
                message: "Incorrect User ID"
            })
        };

        //block someone from sending request to himself
        if (requesterId == recipientId){
            return res.status(400).json({
                message: "You cannot send a request to yourself";
            });
        }

        const friend = await Friendship.create({
            requester: requesterId,
            recipientId: recipientId,
            status: "pending"
        });

        //send notifications to user
        //we should add a notification system here (check your blueprint)

        res.status(201).json({
            message: "Friend request created successfully",
            friend
        })
    } catch (error){
        res.status(500).json({
            message: error.message
        })
    }
};

const acceptRequest = async (req, res) => {
    try {
        const { requesterId, recipientId } = req.body;

        const friend = await Friendship.findOneAndUpdate(
            { $or: [{ requester: requesterId, recipient: recipientId }, { requester: recipientId, recipient: requesterId }] },
            { status: "accepted" },
            { new: true }
        );

        if (!friend) {
            return res.status(404).json({ message: "Friend request not found" });
        }

        const recipient = await User.findById(recipientId).select("username");

        //send notification here too
        //check your blueprint to add this system later too.

        res.status(200).json({
            message: "Friend added successfully",
            friend
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

const rejectRequest = async (req, res) => {
    try {
        const { requesterId, recipientId } = req.body;

        let friendship = await Friendship.findOne({
            $or: [
                {
                    requester: requesterId,
                    recipient: recipientId
                },
                {
                    requester: recipientId,
                    recipient: requesterId,
                }
            ]
        });

        if(!friendship){
            return res.status(400).json({
                message: "Not a friend, cannot reject."
            })
        }
        
        friendship.status = null;
        await friendship.save();

        res.status(200).json({
            message: "The user was rejected."
        })
    } catch (error) {
        res.status(500).json({
            message: error.message
        })
    }
};

const getPendingRequest = async (req, res) => {
    try {
        const { recipientId } = req.body;

        //check if id exist
        const user = await User.findOne({ _id: recipientId });

        if(!user){
            return res.status(400).json({
                message: "User does not exist"
            });
        }

        const relation = await Friendship.find({
                    recipient: recipientId,
                    status: "pending"
        }).populate(
            "requester",
            "name profilePicture"
        )

        if(!relation){
            return res.status(200).json({
                message: "There is no pending request."
            })
        }

        res.status(200).json({
            message: "Requests generated successfully.",
            relation

        })


    } catch (error) {
        res.status(500).json({
            message: error.message
        })
    }
};

const getFriends = async (req, res) => {
    try {
        const {userId} = req.body;

        const user = await User.findOne({ _id: userId });

        //check if user exists
        if(!user){
            return res.status(400).json({
                message: "User not found"
            })
        };

        const friends = await Friendship.find({
            $or: [
                {
                    recipient: userId,
                    status: "accepted"
                },
                {
                    requester: userId,
                    status: "accepted"
                }
            ]
        }).populate(
            "requester",
            "name profilePicture"
        ).populate(
            "recipient",
            "name profilePicture"
        );


        res.status(200).json({
            message: "Fetched Friends successfully",
            friends
        });
    } catch (error) {
        res.status(500).json({
            message: error.message
        })
    }
};

const searchUsers = async (req, res) => {
    try {
        const { userId, query } = req.body;

        if (!userId){
            return res.status(400).json({
                message: "User Id is required."
            });
        }

        const users = await User.find({
            _id: { $ne: userId },
            username: {
                $regex: query || "",
                $options: "i"
            }
        })
        .select("name profilePicture")
        .limit(20);

        const userIds = users.map(user => user._id);

        const friendships = await Friendship.find({
            $or: [
                { requester: userId, recipient: { $in: userIds } },
                { requester: { $in: userIds }, recipient: userId }
            ]
        });

        const relationshipMap = {};
        friendships.forEach(friendship => {
            const otherUser =
                friendship.requester.toString() === userId
                    ? friendship.recipient.toString()
                    : friendship.requester.toString();

            let status = "none";

            if (friendship.status === "accepted"){
                status = "friend";
            } else if (friendship.status === "pending"){
                status = friendship.requester.toString() === userId ? "requested" : "pending";
            } else if (["blocked", "friendBlocked", "pendingBlocked"].includes(friendship.status)){
                status = "blocked";
            }

            relationshipMap[otherUser] = status;
        });

        const results = users.map(user => ({
            id: user._id,
            username: user.username,
            avatarUrl: user.profilePicture?.url,
            status: relationshipMap[user._id.toString()] || "none"
        }));

        res.status(200).json({
            message: "Users fetched successfully.",
            users: results
        });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

export {
    sendRequest,
    acceptRequest,
    rejectRequest,
    getPendingRequest,
    getFriends,
    searchUsers
}