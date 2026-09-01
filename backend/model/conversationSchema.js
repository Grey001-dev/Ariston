import mongoose from "mongoose";

const conversationSchema = new mongoose.Schema({
    roomName: {
        type: String,
        trim: true,
        default: null
    },
    isGroupChat: {
        type: Boolean,
        required: true,
        default: false
    },
    groupavatar: {
        url: { type: String, default: "" }, //need to indicate a default avatar for the group chats
        publicId: { type: String, default: "" }
    },

    participant: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        }
    ],
    latestMessage: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Message" //the  last message to show previews on the sideBar instantly
    },
    groupAdmins: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User'
        }
    ],
    onlyAdminsCanMessage: {
        type: Boolean,
        default: false
    }
},
{
    timestamps: true
})

export default mongoose.model("Conversation", conversationSchema);