module.exports = async function(req, res){
    const userId = req.session.userId
    // await post.destroy({})
    const allPosts = await post.find({user: userId})
        .populate('user')
        .sort('createdAt DESC')

    if(req.wantsJSON){
        return res.send(allPosts)
    }

    res.view('pages/post/home', {
        allPosts
    })
}