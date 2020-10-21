
const timeOut = 3600000;

export const dbConfig = {
    user: process.env.MEGGIT_DB_USER,
    password: process.env.MEGGIT_DB_PASSWORD,
    server: process.env.MEGGIT_DB_SERVER,
    database: process.env.MEGGIT_DB_DATABASE,
    connectionTimeout: timeOut,
    requestTimeout: timeOut,
    pool: {
        idleTimeoutMillis: timeOut,
        max: 100
    },
    options: {
        encrypt: true,
        database: process.env.MEGGIT_DB_DATABASE
    }
};