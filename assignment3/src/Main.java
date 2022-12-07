import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

public class Main {

    final static String HOST = "localhost";
    final static int PORT = 5432;
    final static String DB_NAME = "assignment3";
    final static String USERNAME = "postgres";
    final static String PASSWORD = "freciagrosa";

    final static int TUPLES_NUMBER = 1000000;

    public static void main(String[] args) throws SQLException {
        Connection connection = connect(HOST, PORT, DB_NAME, USERNAME, PASSWORD);
        String command;

        //POINT 1
        command = "DROP TABLE IF EXISTS professor, course;";
        execute_statement(connection, command);


        //POINT 2
        set_autocommit_and_commit(connection, false);
        command = "CREATE TABLE professor("+
                "id int PRIMARY KEY," +
                "name char(50) NOT NULL," +
                "address char(50) NOT NULL," +
                "age int NOT NULL," +
                "department float NOT NULL" +
                ");";
        execute_statement(connection, command);
        command = "CREATE TABLE course(" +
                "cid char(25) PRIMARY KEY," +
                "cname char(50) NOT NULL," +
                "credits char(30) NOT NULL," +
                "teacher int NOT NULL REFERENCES professor" +
                ");";
        execute_statement(connection, command);
        set_autocommit_and_commit(connection, true);


        //POINT 3
        insert_1m_professors(connection);

        try {
            connection.close();
        }
        catch (Exception e) {
            System.err.println("Failed to close connection");
            e.printStackTrace();
        }

    }


    public static void insert_1m_professors(Connection connection) {
        set_autocommit_and_commit(connection, false);
        String command = "INSERT INTO professor(id, name, address, age, department) VALUES(?,?,?,?,?);";
        try {
            PreparedStatement statement = connection.prepareStatement(command);
            Iterator<Integer> ids = get_professor_ids().iterator();
            Iterator<String> name_salts = get_professor_name_salts().iterator();
            Iterator<Integer> address_salts = get_professor_ids().iterator();
            Iterator<Integer> ages = get_professor_ids().iterator();
            Iterator<Integer> departments = get_professor_ids().iterator();
            for (int i = 0; i < TUPLES_NUMBER - 1; i++) {
                statement.setInt(1, ids.next());
                statement.setString(2, "name-" + name_salts.next());
                statement.setString(3, "address-" + address_salts.next());
                statement.setInt(4, ages.next());
                statement.setFloat(5, departments.next() / (float) 2);
                statement.addBatch();
            }
            statement.setInt(1, ids.next());
            statement.setString(2, "name" + name_salts.next());
            statement.setString(3, "address" + address_salts.next());
            statement.setInt(4, ages.next());
            statement.setFloat(5, 1940);
            statement.addBatch();

            statement.executeBatch();
            statement.close();
        }
        catch (Exception e) {
            System.err.println("Failed to prepare statement");
            e.printStackTrace();
        }
        set_autocommit_and_commit(connection, true);
    }

    public static ArrayList<Integer> get_professor_ids() {
        Random random = new Random();
        return random.ints(4000, 69*TUPLES_NUMBER).distinct().limit(TUPLES_NUMBER).boxed().collect(Collectors.toCollection(ArrayList::new));
    }

    public static ArrayList<Integer> get_professor_ages() {
        Random random = new Random();
        return random.ints(25, 99).distinct().limit(TUPLES_NUMBER).boxed().collect(Collectors.toCollection(ArrayList::new));
    }

    public static ArrayList<String> get_professor_name_salts() {
        Random random = new Random();
        char[] alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        ArrayList<String> salts = new ArrayList<>(TUPLES_NUMBER);
        for (int i = 0; i < TUPLES_NUMBER; i++) {
            StringBuilder salt = new StringBuilder();
            for (int j = 0; j < 20; j++) {
                salt.append(alphabet[random.nextInt(alphabet.length)]);
            }
            salts.add(salt.toString());
        }
        return salts;
    }

    public static void set_autocommit_and_commit(Connection connection, boolean status){
        if(status) {
            try {
                connection.commit();
            }
            catch (Exception e) {
                System.err.println("Failed to commit");
                e.printStackTrace();
            }
        }
        try {
            connection.setAutoCommit(status);
        }
        catch (Exception e) {
            System.err.println("Failed to set autocommit to " + status);
            e.printStackTrace();
        }
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