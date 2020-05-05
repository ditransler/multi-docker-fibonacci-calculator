const config = require('./config');
const redis = require('redis');

const redisClient = redis.createClient({
  host: config.redisHost,
  port: config.redisPort,
  retry_strategy: config.retryStrategy
});

const redisSubscription = redisClient.duplicate();

function fib(index) {
  if (index < 2) {
    return 1;
  }

  return fib(index - 1) + fib(index - 2);
}

redisSubscription.on('message', (channel, message) => {
  redisClient.hset('values', message, fib(parseInt(message, 10)));
});

redisSubscription.subscribe('insert');