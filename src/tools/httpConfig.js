const axios = require("axios");
const config = require("config");
const logger = require("../logging");

const url =
  process.env.NODE_ENV !== "production"
    ? config.get("app.deepSpeechBaseUrl")
    : process.env.deepSpeechBaseUrl;

const secret =
  process.env.NODE_ENV !== "production"
    ? config.get("app.deepSpeechAuthKey")
    : process.env.deepSpeechBaseUrl;

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
