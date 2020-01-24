module.exports = async function(req, res){
    //fetch all users using waterline
    const users = await User.find({})
    res.send(users)
}