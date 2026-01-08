package main

import (
	"database/sql"
	"fmt"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	host := os.Getenv("PROXY_HOST")
	port := os.Getenv("PROXY_PORT")
	user := os.Getenv("DB_USER")
	pass := os.Getenv("DB_PASS")

	if host == "" {
		fmt.Println("PROXY_HOST not set")
		return
	}
	if port == "" {
		port = "3306"
	}

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/mysql?timeout=5s&readTimeout=5s&writeTimeout=5s",
		user, pass, host, port)

	db, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Println("✗ open failed:", err)
		os.Exit(1)
	}
	defer db.Close()

	start := time.Now()
	if err := db.Ping(); err != nil {
		fmt.Println("✗ ping failed:", err)
		os.Exit(1)
	}

	var one int
	if err := db.QueryRow("SELECT 1").Scan(&one); err != nil {
		fmt.Println("✗ query failed:", err)
		os.Exit(1)
	}
       var id int
	if err := db.QueryRow("SELECT count(*) from user LIMIT 1").Scan(&id); err != nil {
                fmt.Println("✗ query failed:", err)
                os.Exit(1)
        }

	fmt.Printf("✓ SUCCESS (driver ok) cost=%v\n", time.Since(start))
}
