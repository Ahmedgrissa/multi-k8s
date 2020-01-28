const keys = require('./keys');
const redis = require('redis');
 
const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000
});

console.log(keys, "keys ==========");

const sub = redisClient.duplicate();
sub.subscribe('insert');

function fib(index) {
  if (index < 2) return 1;
  return fib(index - 1) + fib(index - 2);
}
console.log("Before message ============");

sub.on('message', (channel, message) => {
  console.log(fib(parseInt(message)), "fib ============");
  redisClient.hset('values', message, fib(parseInt(message)));
});
console.log("After message ============");

sub.subscribe('insert');
