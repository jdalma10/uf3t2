const mysql = require('mysql');
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "agenda"
    });


function getContactes(req, res){
  
  
  
        con.query("SELECT * FROM contacte ", function (err, result, fields) {
          if (err) throw err;
          res.end(JSON.stringify(result));
        });
  

}

function getContacte(req, res, id){
  
        con.query(`SELECT * FROM contacte WHERE idContacte = ${id}`, function (err, result, fields) {
          if (err) throw err;
          
          res.end(JSON.stringify(result));
        });

}



module.exports = {
    
    getContactes,
    getContacte
}
