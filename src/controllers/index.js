const router = require("express").Router();
const { asyncMiddleware } = require("../middlewares/async");

router.get(
  "/",
  asyncMiddleware(async (req, res) => {

    // TO:DO Send Email
    return res.status(200).send("Welcome to Kaze API.");
  })
);

module.exports = router;
