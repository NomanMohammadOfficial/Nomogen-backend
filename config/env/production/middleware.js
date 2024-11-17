module.exports = ({ env }) => ({
  settings: {
    cors: {
      enabled: true,
      origin: ['https://nomanmohammad.com', 'https://www.nomanmohammad.com', 'http://localhost:3000'],
      credentials: true,
      methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'],
      headers: ['Content-Type', 'Authorization', 'Origin', 'Accept'],
    },
  },
});
