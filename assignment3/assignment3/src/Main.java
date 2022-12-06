import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class Main {

    final static String HOST = "localhost";
    final static String PORT = "5432";
    final static String DB_NAME = "assignment3";
    final static String USERNAME = "postgres";
    final static String PASSWORD = "freciagrosa";

    public static void main(String[] args) {
        
    }

    public static Connection connect(String host, int port, String database, String user, String password){
        Connection database_connection = null;
        try {
            Class.forName("org.postgresql.Driver");
            database_connection = DriverManager.getConnection("jdbc:postgresql://"+host+":"+port+"/"+database, user, password);
        }
        catch (Exception e) {
            System.err.println("Failed to connect to database");
            e.printStackTrace();
        }
        return database_connection;
    }

    public static void execute_statement(Connection database_connection, String sql_statement) {
        try {
            Statement statement = database_connection.createStatement();
            statement.execute(sql_statement);
            statement.close();
        }
        catch (Exception e) {
            System.err.println("Failed to execute statement");
            e.printStackTrace();
        }
    }

    public static ResultSet execute_query(Connection database_connection, String sql_query) {
        ResultSet result = null;
        try {
            Statement statement = database_connection.createStatement();
            result = statement.executeQuery(sql_query);
        }
        catch (Exception e) {
            System.err.println("Failed to execute query");
            e.printStackTrace();
        }
        return result;
    }
}