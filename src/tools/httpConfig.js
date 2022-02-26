const axios = require("axios");
const config = require("config");
const logger = require("../logging");
const url = config.get("app.deepSpeechBaseUrl");
const secret = config.get("app.deepSpeechAuthKey");

const deepSpeech = axios.create({
  baseURL: url,
  headers: {
    Authorization: "Bearer " + secret,
  },
});

deepSpeech.interceptors.request.use((configuration) => {
  console.log(configuration);
  const { url, method, params } = configuration;
  logger.info({ url, method, params }, "Requesting data from deepSpeech API");

  return configuration;
});

module.exports.deepSpeech = deepSpeech;
