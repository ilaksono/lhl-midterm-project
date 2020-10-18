const express = require('express');
const router  = express.Router();
const bcrypt = require("bcrypt")


module.exports = (db) => {
  router.get("/", (req, res) => {
    return res.render('login')
  });

  router.post("/", (req, res) => {
    const user = req.body
    req.session.userId = "";
    const query = `
    SELECT * FROM users
    WHERE email = $1
    `
    if (user.email === "" || user.password === "") {
      err_msg = 'Please enter valid email and password';
      return res.render('login', { err_msg: err_msg } );
    }
    db.query(query, [user.email])
    .then(response => {
      const dbUser = response.rows[0]
      if (dbUser) {
        bcrypt.compare(user.password, dbUser.password, (err, result) => {
          if (result) {
            res.redirect('maps')
            req.session.userId = dbUser.id;
          } else {
            err_msg = 'Failed to login';
            return res.render('login', { err_msg: err_msg } );
          }
        })
      } else {
        err_msg = 'Failed to login';
        return res.render('login', { err_msg: err_msg } );
      }
    })
  });

  return router;
};
