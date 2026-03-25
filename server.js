const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 8000;

const server = http.createServer((req, res) => {
    // Servir caja.html por defecto
    let filePath = path.join(__dirname, 'caja.html');
    
    // Si es la raíz, servir caja.html
    if (req.url === '/' || req.url === '') {
        filePath = path.join(__dirname, 'caja.html');
    } else {
        filePath = path.join(__dirname, req.url);
    }
    
    // Obtener extensión del archivo
    const extname = path.extname(filePath);
    let contentType = 'text/html';
    
    // Configurar content type según extensión
    switch (extname) {
        case '.js':
            contentType = 'text/javascript';
            break;
        case '.css':
            contentType = 'text/css';
            break;
        case '.json':
            contentType = 'application/json';
            break;
        case '.png':
            contentType = 'image/png';
            break;
        case '.jpg':
            contentType = 'image/jpg';
            break;
        case '.ico':
            contentType = 'image/x-icon';
            break;
    }
    
    // Leer y servir el archivo
    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                // Si no existe, servir caja.html
                fs.readFile(path.join(__dirname, 'caja.html'), (err, content) => {
                    if (err) {
                        res.writeHead(500, { 'Content-Type': 'text/html' });
                        res.end('<h1>Error 500 - Server Error</h1>');
                    } else {
                        res.writeHead(200, { 'Content-Type': 'text/html' });
                        res.end(content);
                    }
                });
            } else {
                res.writeHead(500, { 'Content-Type': 'text/html' });
                res.end('<h1>Error 500 - Server Error</h1>');
            }
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content);
        }
    });
});

server.listen(PORT, () => {
    console.log(`🍽️ Caja POS server running on port ${PORT}`);
    console.log(`🌐 URL: http://localhost:${PORT}`);
});
