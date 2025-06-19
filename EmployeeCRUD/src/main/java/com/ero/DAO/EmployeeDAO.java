package com.ero.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ero.model.Employee;
import util.DBConnection;

public class EmployeeDAO {

    public boolean insertEmployee(Employee emp) {
        String sql = "INSERT INTO EMPLOYEE_ERO (EMPLOYEEID, FIRSTNAME, LASTNAME, HIREDDATE, AGE, JOBLEVEL) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, emp.getEmployeeId());
            stmt.setString(2, emp.getFirstName());
            stmt.setString(3, emp.getLastName());
            stmt.setDate(4, emp.getHiredDate()); // java.sql.Date
            stmt.setInt(5, emp.getAge());
            stmt.setInt(6, emp.getJobLevel());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // You can log this instead
        }

        return false;
    }
    
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();

        String sql = "SELECT * FROM EMPLOYEE_ERO ORDER BY EMPLOYEE_EROID DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmployeeEroId(rs.getInt("EMPLOYEE_EROID"));
                emp.setEmployeeId(rs.getString("EMPLOYEEID"));
                emp.setFirstName(rs.getString("FIRSTNAME"));
                emp.setLastName(rs.getString("LASTNAME"));
                emp.setHiredDate(rs.getDate("HIREDDATE"));
                emp.setAge(rs.getInt("AGE"));
                emp.setJobLevel(rs.getInt("JOBLEVEL"));
                list.add(emp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}
