module.exports = {
  redisHost: process.env.REDIS_HOST,
  redisPort: process.env.REDIS_PORT,
  retryStrategy: () => 1000 // 1 sec
};