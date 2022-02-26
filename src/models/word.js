const mongoose = require("mongoose");
const Joi = require("@hapi/joi");

const wordSchema = new mongoose.Schema({
  text_en: {
    type: String,
  },
  text_kin: {
    type: String,
  },
  audio_url: {
    type: String,
  }
});

const words = mongoose.model("words", wordSchema);

const validateWord = (postData) => {
  const schema = {
    text_en: Joi.string().min(1),
    text_kin: Joi.string().min(1),
    audio_url: Joi.string().min(1),
  };
  return Joi.object(schema).validate(postData);
};

module.exports.Word = words;
module.exports.validate = validateWord;
