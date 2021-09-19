import admin from "firebase-admin";
const usersRef = admin.firestore().collection("users");

class UserController {
  async get(req, res) {
    let user = await usersRef.doc(req.body.id).get().data();
    if (user.empty) return res.status(404);
    return res.status(200).json(user);
  }

  async create(req, res) {
    await usersRef.doc(req.body.id).set({
      name: req.body.name,
      profileImageUrl: req.body.profileImageUrl,
    });

    return res.status(200);
  }

  async update(req, res) {
    await usersRef.doc(req.body.id).set({
      name: req.body.name,
      profileImageUrl: req.body.profileImageUrl,
    });

    return res.status(200);
  }
}

export default new UserController();
