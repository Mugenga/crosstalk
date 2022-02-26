const deepSpeech = require("../tools/httpConfig").deepSpeech;
const axios = require("axios");
const config = require("config");
const url = config.get("app.deepSpeechBaseUrl");
const secret = config.get("app.deepSpeechAuthKey");

// Send Audio to DeepSpeech API for speech to txt response

const sendAudio = async (form) => {
  try {
    return await axios({
      method: "post",
      url: url + "/api/v1/stt/http",
      data: form,
      headers: {
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
