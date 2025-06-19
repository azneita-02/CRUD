package com.ero.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import com.ero.DAO.EmployeeDAO;
import com.ero.model.Employee;

/**
 * Servlet implementation class AddEmployeeServlet
 */
@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {
	
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // Get parameters from form (or AJAX)
            String empId = request.getParameter("employeeId");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String hiredDateStr = request.getParameter("hiredDate"); // e.g., 25-MAY-26
            int age = Integer.parseInt(request.getParameter("age"));
            int jobLevel = Integer.parseInt(request.getParameter("jobLevel"));

            // Convert to java.sql.Date
            SimpleDateFormat sdf = new SimpleDateFormat("yy-MMM-dd");
            java.util.Date utilDate = sdf.parse(hiredDateStr);
            Date sqlDate = new Date(utilDate.getTime());

            // Build model object
            Employee emp = new Employee(empId, firstName, lastName, sqlDate, age, jobLevel);

            // Call DAO
            EmployeeDAO dao = new EmployeeDAO();
            boolean result = dao.insertEmployee(emp);

            response.setContentType("text/plain");
            response.getWriter().write(result ? "success" : "error");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("error");
        }
	}

}
