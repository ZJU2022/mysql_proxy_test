import os
import time
import mysql.connector
from mysql.connector import Error

PROXY_HOST = os.getenv("PROXY_HOST")
PROXY_PORT = int(os.getenv("PROXY_PORT", "3306"))
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")

if not PROXY_HOST or not DB_USER or not DB_PASS:
    print("✗ PROXY_HOST, DB_USER, or DB_PASS not set")
    exit(1)

start = time.time()
try:
    conn = mysql.connector.connect(
        host=PROXY_HOST,
        port=PROXY_PORT,
        user=DB_USER,
        password=DB_PASS,
        database="mysql",
        connection_timeout=5
    )

    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute("SELECT 1")
        one = cursor.fetchone()[0]

        cursor.execute("SELECT count(*) FROM user LIMIT 1")
        count = cursor.fetchone()[0]

        print(f"✓ SUCCESS (driver ok) SELECT 1={one} COUNT user={count} cost={time.time()-start:.3f}s")
    else:
        print("✗ Connection failed")
except Error as e:
    print(f"✗ Error: {e}")
finally:
    if 'conn' in locals() and conn.is_connected():
        conn.close()

