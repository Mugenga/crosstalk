/* eslint-disable max-len */
const error = require("../middlewares/error");
const word = require("../controllers/words");
const index = require("../controllers/index");

const mountRoutes = (app) => {
  // Intercept body JSON error to overwrite the existing error message
  app.use((error, req, res, next) => {
    if (
      error instanceof SyntaxError &&
      error.status === 400 &&
      "body" in error
    ) {
      logger.error(error);
      next();
    } else next();
  });

  app.use("/", index);
  app.use("/words", word);

  // Call error handling at the end
  app.use(error);
};

module.exports = {
  mountRoutes,
};
