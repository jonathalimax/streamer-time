class StreamerController {
  favorite(req, res) {
    return res
      .status(200)
      .json({ userId: req.params.user, streamerId: req.body.streamerId });
  }
}

export default new StreamerController();