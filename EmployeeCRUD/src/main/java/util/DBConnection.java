package util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnection {

    public static Connection getConnection() {
        try {
            // Get initial context
            Context initContext = new InitialContext();
            // Lookup environment context (standard JNDI path)
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            // Lookup the resource name defined in context.xml
            DataSource ds = (DataSource) envContext.lookup("jdbc/Employee");

            // Return a connection from the pool
            return ds.getConnection();

        } catch (Exception e) {
            e.printStackTrace(); // You can log this in production
            return null;
        }
    }
}