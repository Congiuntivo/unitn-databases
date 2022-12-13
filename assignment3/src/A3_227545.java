import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;
import java.util.stream.Collectors;

public class A3_227545 {

//        final static String HOST = "localhost";
    final static String HOST = "sci-didattica.unitn.it";
    final static int PORT = 5432;
//    final static String DB_NAME = "assignment3";
    final static String DB_NAME = "db_013";
//    final static String USERNAME = "postgres";
    final static String USERNAME = "db_013";
    final static String PASSWORD = "freciagrosa";

    final static int TUPLES_NUMBER = 1000000;

    final static int TIME_MULTIPLIER = 1000;

    final static int BATCH_SIZE = 100000;

    public static void main(String[] args) {
        Connection connection = connect(HOST, PORT, DB_NAME, USERNAME, PASSWORD);
        String command;

        //POINT 1
        long time = System.currentTimeMillis();
        command = "DROP TABLE IF EXISTS Professor, Course;";
        execute_statement(connection, command);
        System.out.println("Step 1 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");


        //POINT 2
        time = System.currentTimeMillis();
        set_autocommit_and_commit(connection, false);
        command = "CREATE TABLE Professor("+
                "id int PRIMARY KEY," +
                "name char(50) NOT NULL," +
                "address char(50) NOT NULL," +
                "age int NOT NULL," +
                "department float NOT NULL" +
                ");";
        execute_statement(connection, command);
        command = "CREATE TABLE Course(" +
                "cid char(25) PRIMARY KEY," +
                "cname char(50) NOT NULL," +
                "credits char(30) NOT NULL," +
                "teacher int NOT NULL REFERENCES Professor" +
                ");";
        execute_statement(connection, command);
        set_autocommit_and_commit(connection, true);
        System.out.println("Step 2 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");


        //POINT 3
        time = System.currentTimeMillis();
        ArrayList<Integer> professor_ids = get_different_random_integers(0, 100 * TUPLES_NUMBER);
        insert_1m_professors(connection, professor_ids.iterator());
        System.out.println("Step 3 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 4
        time = System.currentTimeMillis();
        insert_1m_courses(connection, professor_ids.iterator());
        System.out.println("Step 4 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 5
        time = System.currentTimeMillis();
        command = "SELECT id FROM Professor;";
        print_results(execute_query(connection, command), 1);
        System.out.println("Step 5 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 6
        time = System.currentTimeMillis();
        command = "UPDATE Professor SET department = 1973 WHERE department = 1940;";
        execute_statement(connection, command);
        System.out.println("Step 6 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 7
        time = System.currentTimeMillis();
        command = "SELECT id, address FROM Professor WHERE department = 1973;";
        print_results(execute_query(connection, command), 2);
        System.out.println("Step 7 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 8
        time = System.currentTimeMillis();
        command = "CREATE INDEX ON Professor USING btree (department)";
        execute_statement(connection, command);
        System.out.println("Step 8 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 9
        time = System.currentTimeMillis();
        command = "SELECT id FROM Professor;";
        print_results(execute_query(connection, command), 1);
        System.out.println("Step 9 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");

        //POINT 10
        time = System.currentTimeMillis();
        command = "UPDATE Professor SET department = 1974 WHERE department = 1973;";
        execute_statement(connection, command);
        System.out.println("Step 10 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");


        //POINT 11
        time = System.currentTimeMillis();
        command = "SELECT id, address FROM Professor WHERE department = 1974;";
        print_results(execute_query(connection, command), 2);
        System.out.println("Step 11 needs " + ((System.currentTimeMillis() - time) * TIME_MULTIPLIER) + " ns");



        try {
            connection.close();
        }
        catch (Exception e) {
            System.err.println("Failed to close connection");
            e.printStackTrace();
        }

    }


    public static void print_results(ResultSet results, int columns) {
        try {
            while (results.next()) {
                System.err.print(results.getString(1));
                for (int i = 2; i <= columns; i++) {
                    System.err.print(", " + results.getString(i));
                }
                System.err.println();
            }
        }
        catch (Exception e) {
            System.err.println("Failed to print results");
            e.printStackTrace();
        }
    }

    public static void insert_1m_professors(Connection connection, Iterator<Integer> professor_ids) {
        set_autocommit_and_commit(connection, false);
        String command = "INSERT INTO Professor(id, name, address, age, department) VALUES(?,?,?,?,?);";
        try {
            Iterator<String> name_salts = get_name_salts().iterator();
            Iterator<Integer> address_salts = get_different_random_integers(0, 100 * TUPLES_NUMBER).iterator();
            Iterator<Integer> ages = get_random_integers(25, 99).iterator();
            Iterator<Integer> departments = get_different_random_integers(4000, 100 * TUPLES_NUMBER).iterator();
            for (int j = 0; j < (TUPLES_NUMBER / BATCH_SIZE) -  1; j++) {
                PreparedStatement statement = connection.prepareStatement(command);
                for (int i = 0; i < BATCH_SIZE; i++) {
                    statement.setInt(1, professor_ids.next());
                    statement.setString(2, "name-" + name_salts.next());
                    statement.setString(3, "address-" + address_salts.next());
                    statement.setInt(4, ages.next());
                    statement.setFloat(5, departments.next() / (float) 2);
                    statement.addBatch();
                }
                statement.executeBatch();
                statement.close();
                connection.commit();
            }
            PreparedStatement statement = connection.prepareStatement(command);
            for (int i = 0; i < BATCH_SIZE - 1; i++) {
                statement.setInt(1, professor_ids.next());
                statement.setString(2, "name-" + name_salts.next());
                statement.setString(3, "address-" + address_salts.next());
                statement.setInt(4, ages.next());
                statement.setFloat(5, departments.next() / (float) 2);
                statement.addBatch();
            }
            statement.setInt(1, professor_ids.next());
            statement.setString(2, "name-" + name_salts.next());
            statement.setString(3, "address-" + address_salts.next());
            statement.setInt(4, ages.next());
            statement.setFloat(5, 1940);
            statement.addBatch();

            statement.executeBatch();
            statement.close();
            connection.commit();
        }
        catch (Exception e) {
            System.err.println("Failed to prepare statement\n" + command);
            e.printStackTrace();
        }
        set_autocommit_and_commit(connection, true);
    }

    public static void insert_1m_courses(Connection connection, Iterator<Integer> teacher_ids) {
        set_autocommit_and_commit(connection, false);
        String command = "INSERT INTO Course(cid, cname, credits, teacher) VALUES(?,?,?,?);";
        try {
            Iterator<Integer> ids = get_different_random_integers(0, 10*TUPLES_NUMBER).iterator();
            Iterator<String> name_salts = get_name_salts().iterator();
            Iterator<Integer> credits = get_random_integers(1, 25).iterator();
            while (ids.hasNext()) {
                PreparedStatement statement = connection.prepareStatement(command);
                for (int i = 0; i < BATCH_SIZE; i++) {
                    statement.setInt(1, ids.next());
                    statement.setString(2, "name-" + name_salts.next());
                    statement.setInt(3, credits.next());
                    statement.setInt(4, teacher_ids.next());
                    statement.addBatch();
                }
                statement.executeBatch();
                statement.close();
                connection.commit();
            }
        }
        catch (Exception e) {
            System.err.println("Failed to prepare statement:\n" + command);
            e.printStackTrace();
        }
        set_autocommit_and_commit(connection, true);
    }


    public static ArrayList<Integer> get_different_random_integers(int from, int to) {
        Random random = new Random();
        return random.ints(from, to).distinct().limit(TUPLES_NUMBER).boxed().collect(Collectors.toCollection(ArrayList::new));
    }

    public static ArrayList<Integer> get_random_integers(int from, int to) {
        Random random = new Random();
        return random.ints(from, to).limit(TUPLES_NUMBER).boxed().collect(Collectors.toCollection(ArrayList::new));
    }

    public static ArrayList<String> get_name_salts() {
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
            System.exit(1);
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