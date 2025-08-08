// Enhanced Redis-enabled weather service
import redis from 'redis';

const API_KEY = process.env.WEATHER_API_KEY;
const REDIS_HOST = process.env.REDIS_HOST;
const REDIS_PORT = process.env.REDIS_PORT || 6380;
const REDIS_PASSWORD = process.env.REDIS_PASSWORD;
const TEN_MINUTES = 60 * 10; // Redis expiry in seconds

// Initialize Redis client
const redisClient = redis.createClient({
  host: REDIS_HOST,
  port: REDIS_PORT,
  password: REDIS_PASSWORD,
  tls: {} // Required for Azure Redis
});

interface FetchWeatherDataParams {
  lat: number;
  lon: number;
  units: string;
}

export async function fetchWeatherData({
  lat,
  lon,
  units
}: FetchWeatherDataParams) {
  const baseURL = 'https://api.openweathermap.org/data/3.0/onecall';
  const queryString = `lat=${lat}&lon=${lon}&units=${units}&appid=${API_KEY}`;
  const cacheKey = `weather:${queryString}`;

  try {
    // Try to get from Redis cache first
    const cachedData = await redisClient.get(cacheKey);
    if (cachedData) {
      console.log('Cache hit - returning cached weather data');
      return JSON.parse(cachedData);
    }

    // If not in cache, fetch from API
    console.log('Cache miss - fetching from OpenWeather API');
    const response = await fetch(`${baseURL}?${queryString}`);
    const data = await response.json();

    // Store in Redis cache with 10 minute expiry
    await redisClient.setex(cacheKey, TEN_MINUTES, JSON.stringify(data));
    
    return data;
  } catch (error) {
    console.error('Redis error, falling back to API call:', error);
    // Fallback to direct API call if Redis fails
    const response = await fetch(`${baseURL}?${queryString}`);
    return await response.json();
  }
}

export async function getGeoCoordsForPostalCode(
  postalCode: string,
  countryCode: string
) {
  const cacheKey = `geocode:${postalCode}:${countryCode}`;
  
  try {
    const cachedData = await redisClient.get(cacheKey);
    if (cachedData) {
      return JSON.parse(cachedData);
    }

    const url = `http://api.openweathermap.org/geo/1.0/zip?zip=${postalCode},${countryCode}&appid=${API_KEY}`;
    const response = await fetch(url);
    const data = await response.json();
    
    // Cache geocoding results for longer (1 day) as they don't change often
    await redisClient.setex(cacheKey, 86400, JSON.stringify(data));
    
    return data;
  } catch (error) {
    console.error('Redis error for geocoding, falling back to API call:', error);
    const url = `http://api.openweathermap.org/geo/1.0/zip?zip=${postalCode},${countryCode}&appid=${API_KEY}`;
    const response = await fetch(url);
    return await response.json();
  }
}
