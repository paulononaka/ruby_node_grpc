const http = require('http');
const app = require('./src/app');

const server = http.createServer(app);
const port = '3000';

app.set('port', port);

server.listen(port);
