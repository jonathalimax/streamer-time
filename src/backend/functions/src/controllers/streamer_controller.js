class StreamerController {
  folllow(req, res) {
    return res
      .status(200)
      .json({ userId: req.params.user, streamerId: req.body.streamerId });
  }

  unfollow(req, res) {
    return res
      .status(200)
      .json({ userId: req.params.user, streamerId: req.body.streamerId });
  }

  getFollowed(req, res) {
    return res
      .status(200)
      .json({ userId: req.params.user, streamerId: req.body.streamerId });
  }

  getFollowing(req, res) {
    return res
      .status(200)
      .json({ userId: req.params.user, streamerId: req.body.streamerId });
  }
}

export default new StreamerController();