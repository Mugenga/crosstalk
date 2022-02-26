const config = require("config");

const getMediaurl = (url) => {
  url = url.replace("\\", "/");
  return `${config.get("app.baseUrl")}/audio/${url}`;
};

module.exports.getMediaurl = getMediaurl;
