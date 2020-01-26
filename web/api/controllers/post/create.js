module.exports = async function(req, res){
    const postBody = req.body.postBody
    console.log("Create a post object with:" + postBody)
    
    const file = req.file('imagefile')
    //Let's upload the image to AWS S3:

    // const options =
    //   { // This is the usual stuff
    //     adapter: require('skipper-better-s3')
    //   , key: 'AKIAJGZVJHAKLQ43HSXQ'
    //   , secret: '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'
    //   , bucket: 'fullstack-images-instaclone'
    //     // Let's use the custom s3params to upload this file as publicly
    //     // readable by anyone
    //   , s3params:
    //         { ACL: 'public-read'
    //         }
    //     // And while we are at it, let's monitor the progress of this upload
    //   , onProgress: progress => sails.log.verbose('Upload progress:', progress)
    //   }
 
file.upload(options, async (err, files) => {
    if (err) {return res.serverError(err.toString()) }
    
    //Success
    const fileUrl = files[0].extra.Location
    const userId = req.session.userId
    await post.create({
        text: postBody,
        user: userId,
        imageUrl: fileUrl
    }).fetch()
    res.redirect('/home')
})

    //return res.end()
    // const userId = req.session.userId
    // const record = await post.create({text: postBody, user: userId}).fetch()

    // // res.send(record)
    // res.redirect('/home')
}