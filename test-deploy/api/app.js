const express = require('express');
const app = express();
const port = 8000;
const { Pool, Connection } = require('pg');

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: '5432',
});

app.get('/', async (req, res) => {
  try {
    const {rows} = await pool.query('SELECT 1+1 AS result, version() AS pg_version');
    
    res.json({ 
      status: 'OK',
      dbResponse: rows[0],
      connection: 'Упешное подключение к БД'
    });
  }
    catch (err){
    res.status(500).json({
      error: err.message,
      note: "Ошибка подключения к БД"
    });
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Сервер запущен на http://0.0.0.0:${port}`);
});
