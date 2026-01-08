import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) throws Exception {

        String host = System.getenv("PROXY_HOST");
        String port = System.getenv("PROXY_PORT");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASS");

        if (host == null || host.isEmpty()) {
            System.out.println("PROXY_HOST not set");
            System.exit(1);
        }
        if (port == null || port.isEmpty()) {
            port = "3306";
        }

        String url =
            "jdbc:mysql://" + host + ":" + port +
            "/mysql?connectTimeout=5000&socketTimeout=5000&useSSL=false";

        long start = System.currentTimeMillis();

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery("SELECT 1");
            rs.next();

            ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM user");
            rs2.next();

            long cost = System.currentTimeMillis() - start;
            System.out.println("✓ SUCCESS (driver ok) cost=" + cost + "ms");
        }
    }
}

