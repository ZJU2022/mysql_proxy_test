using System;
using MySql.Data.MySqlClient;

class Program
{
    static void Main()
    {
        string host = Environment.GetEnvironmentVariable("PROXY_HOST");
        string port = Environment.GetEnvironmentVariable("PROXY_PORT") ?? "3306";
        string user = Environment.GetEnvironmentVariable("DB_USER");
        string pass = Environment.GetEnvironmentVariable("DB_PASS");

        if (string.IsNullOrEmpty(host))
        {
            Console.WriteLine("PROXY_HOST not set");
            return;
        }

        string connStr = $"server={host};port={port};user={user};password={pass};database=mysql;Connection Timeout=5;";
        try
        {
            using (var conn = new MySqlConnection(connStr))
            {
                conn.Open();
                var cmd = new MySqlCommand("SELECT 1", conn);
                var result = cmd.ExecuteScalar();
                Console.WriteLine($"✓ SUCCESS (driver ok), SELECT 1 = {result}");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"✗ FAILED: {ex.Message}");
        }
    }
}

