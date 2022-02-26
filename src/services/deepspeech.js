const deepSpeech = require("../tools/httpConfig").deepSpeech;
const axios = require("axios");
const config = require("config");
const url =
  process.env.NODE_ENV !== "production"
    ? config.get("app.deepSpeechBaseUrl")
    : process.env.deepSpeechBaseUrl;

const secret =
  process.env.NODE_ENV !== "production"
    ? config.get("app.deepSpeechAuthKey")
    : process.env.deepSpeechBaseUrl;

// Send Audio to DeepSpeech API for speech to txt response

const sendAudio = async (form) => {
  try {
    return await axios({
      method: "post",
      url: url + "/api/v1/stt/http",
      data: form,
      headers: {
        ...form.getHeaders(),
        'Content-Type': "multipart/form-data",
        Authorization: "Bearer " + secret,
      },
    });
  } catch (error) {
    console.log(error.response)
    return error;
  }
};

// const sendAudio = async (data) => {
//   try {
//     return await deepSpeech.post("/api/v1/stt/http", data);
//   } catch (error) {
//     return error;
//   }
// };

module.exports.sendAudio = sendAudio;
