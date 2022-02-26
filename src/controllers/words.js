const base64Img = require("base64-img");
const isJSON = require("is-json");
const router = require("express").Router();
const fs = require("fs");

const { asyncMiddleware } = require("../middlewares/async");
const { getLoggedInUserId, getMediaurl } = require("../tools/common");
const { ObjectID } = require("mongodb");
const { Word, validate } = require("../models/word");

const multer = require("multer");

const storage = multer.diskStorage({
  filename: function (req, file, cb) {
    //console.log("filename");
    cb(null, file.originalname);
  },
  destination: function (req, file, cb) {
    //console.log("storage");
    cb(null, "./public/uploads");
  },
});

const upload = multer({ storage });

const _ = require("lodash");
const { sendAudio } = require("../services/deepspeech");
const { send } = require("process");

// Create Word/Sentence
router.post(
  "/",
  asyncMiddleware(async (req, res) => {
    //Check if a valid json object is provided
    if (!isJSON(JSON.stringify(req.body)))
      return res
        .status(400)
        .send({ status: 400, errors: ["Investigate your body request."] });

    //validate input  data
    const { error } = validate(req.body);
    if (error)
      return res.status(400).send({
        status: 400,
        errors: [error.details[0].message],
      });

    const word = new Word(req.body);
    const data = await word.save();

    return res.status(200).send({
      status: 200,
      data: data,
      message: "successful",
    });
  })
);

// Get Single Word/sentence
router.get(
  "/:id",
  asyncMiddleware(async (req, res) => {
    const word = await Word.findById(req.params.id);
    // Get ful audio url.
    word.audio_url = getMediaurl(word.audio_url);
    return res.status(200).send({
      status: 200,
      data: word,
      message: "successful",
    });
  })
);

// Get All Words
router.get(
  "/",
  asyncMiddleware(async (req, res) => {
    const words = await Word.find();
    words.forEach((word) => (word.audio_url = getMediaurl(word.audio_url)));
    return res.status(200).send({
      status: 200,
      data: words,
      message: "successful",
    });
  })
);

// Receive audio from mobile app
router.post(
  "/audio",
  upload.single("audio"),
  asyncMiddleware(async (req, res) => {
    const FormData = require("form-data");
    var form = new FormData();
    //consider req.file is the file coming from multer
    const file = fs.createReadStream(req.file.originalname);
    let emptyFile = true;

    file.once("data", (chunk) => {
      emptyFile = false;
    });

    file.on("end", () => {
      console.log("Stream ended");
      if (emptyFile) {
        console.log("Empty file");
      }
    });

    //return res.send("lol");

    form.append("audio", fs.createReadStream(req.file.path));
    form.append("namme", "Yves Mugeng");

    console.log(form);

    const response = await sendAudio(form);
    if (response.response.status == 200) {
      // const word = new Word(req.body);
      // const data = await word.save();

      return res.status(200).send({
        status: 200,
        //data: data,
        message: "successful",
      });
    } else {
      return res.status(500).send({
        status: 500,
        message: "Internal Error.",
      });
    }
  })
);

module.exports = router;
