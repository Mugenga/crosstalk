const isJSON = require("is-json");
const router = require("express").Router();
const fs = require("fs/promises");
const FormData = require("form-data");
const { asyncMiddleware } = require("../middlewares/async");
const { getMediaurl } = require("../tools/common");
const { Word, validate } = require("../models/word");

// Muller to accept audio files
const multer = require("multer");

const storage = multer.diskStorage({
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
  destination: function (req, file, cb) {
    cb(null, "./public/uploads");
  },
});

const upload = multer({ storage });

const { sendAudio } = require("../services/deepspeech");

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

// Get Words by Category
router.get(
  "/:cat/categories",
  asyncMiddleware(async (req, res) => {
    const words = await Word.find({category: req.params.cat});
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
    // Read image from disk as a Buffer
    const image = await fs.readFile(req.file.path);
    const file = req.file;

    // Build form request to send to deepspeech api
    let form = new FormData();
    form.append("audio", image, file.filename);

    console.log("Waiting for data from Deepspeech API..........");
    const response = await sendAudio(form);
    console.log("End");

    console.log(response.data);
    // If response
    if (response.status == 200) {
      const message = response.data.message;
      const word = await Word.findById(req.body.id);

      console.log(`System Text: ${word.text_kin}`);
      console.log(`User Transcibed Text: ${message}`);

      // Find Simirality between user transcribed voice and pre-scribed voice
      const percentage = similarity(word.text_kin, message);

      return res.status(200).send({
        status: 200,
        data: percentage * 100,
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

// Function to find similarity between words
const similarity = (s1, s2) => {
  var longer = s1;
  var shorter = s2;
  if (s1.length < s2.length) {
    longer = s2;
    shorter = s1;
  }
  var longerLength = longer.length;
  if (longerLength == 0) {
    return 1.0;
  }
  return (
    (longerLength - editDistance(longer, shorter)) / parseFloat(longerLength)
  );
};

// For each word based on how scattered are the char, find a distance 
const editDistance = (s1, s2) => {
  s1 = s1.toLowerCase();
  s2 = s2.toLowerCase();

  var costs = new Array();
  for (var i = 0; i <= s1.length; i++) {
    var lastValue = i;
    for (var j = 0; j <= s2.length; j++) {
      if (i == 0) costs[j] = j;
      else {
        if (j > 0) {
          var newValue = costs[j - 1];
          if (s1.charAt(i - 1) != s2.charAt(j - 1))
            newValue = Math.min(Math.min(newValue, lastValue), costs[j]) + 1;
          costs[j - 1] = lastValue;
          lastValue = newValue;
        }
      }
    }
    if (i > 0) costs[s2.length] = lastValue;
  }
  return costs[s2.length];
};

module.exports = router;
