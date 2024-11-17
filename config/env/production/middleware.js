module.exports = ({ env }) => ({
  settings: {
    cors: {
      enabled: true,
      origin: [
        'https://nomanmohammad.com',
        'https://www.nomanmohammad.com',
        'http://localhost:3000',
        'http://localhost:5173', 
        'http://127.0.0.1:5173'  
      ],
      credentials: true,
      methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'],
      headers: [
        'Content-Type',
        'Authorization',
        'Origin',
        'Accept',
        'Access-Control-Allow-Origin',
        'Access-Control-Allow-Credentials',
        'Access-Control-Allow-Headers',
        'Access-Control-Allow-Methods'
      ],
    },
  },
});
