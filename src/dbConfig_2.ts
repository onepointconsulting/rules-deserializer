
const timeOut = 3600000;

export const dbConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_DATABASE,
    connectionTimeout: timeOut,
    requestTimeout: timeOut,
    pool: {
        idleTimeoutMillis: timeOut,
        max: 100
    },
    options: {
        encrypt: true,
        database: process.env.DB_DATABASE
    }
};