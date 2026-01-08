const mysql = require('mysql2');

const host = process.env.PROXY_HOST;
const port = process.env.PROXY_PORT || 3306;
const user = process.env.DB_USER;
const password = process.env.DB_PASS;

if (!host || !user) {
  console.error('PROXY_HOST or DB_USER not set');
  process.exit(1);
}

const conn = mysql.createConnection({
  host,
  port,
  user,
  password,
  database: 'mysql'
});

conn.connect(err => {
  if (err) {
    console.error('✗ FAILED:', err.message);
    process.exit(1);
  }

  conn.query('SELECT 1', (err, rows) => {
    if (err) {
      console.error('✗ FAILED:', err.message);
      process.exit(1);
    }

    console.log('✓ SUCCESS (classic protocol), SELECT 1 =', rows[0]['1'] || rows[0][0]);
    conn.end();
  });
});

