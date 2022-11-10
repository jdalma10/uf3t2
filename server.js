const http = require('http');
const mysql = require('mysql');
const {
  getContactes,
  getContacte
} = require('./utils');

const server = http.createServer((req, res) => {
  if (req.url === '/contacte' && req.method === 'GET') {
    getContactes(req,res)
  } else if (req.url.match(/\/contacte\/\w+/) && req.method === 'GET') {
    var id = req.url.split('/')[2];
    console.log(id);
    getContacte(req, res, id);
  } else {
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(
      JSON.stringify({
        message: 'Route Not Found: Utilitza endpoint  contacte o contacte/id',
      })
    );
  }
});

const PORT = process.env.PORT || 5000;

server.listen(PORT, () => console.log(`Server running on port ${PORT}`));

module.exports = server;
