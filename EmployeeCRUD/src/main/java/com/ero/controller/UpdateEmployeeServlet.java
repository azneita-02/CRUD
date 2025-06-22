package com.ero.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

import com.ero.DAO.EmployeeDAO;
import com.ero.model.Employee;


@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet extends HttpServlet {
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int employeeEroId = Integer.parseInt(request.getParameter("employeeEroId"));
		String employeeId = request.getParameter("employeeId");
		String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        Date hiredDate = Date.valueOf(request.getParameter("hiredDate"));
        int age = Integer.parseInt(request.getParameter("age"));
        int jobLevel = Integer.parseInt(request.getParameter("jobLevel"));
        
        Employee emp = new Employee(employeeEroId, employeeId, firstName, lastName, hiredDate, age, jobLevel);
        
        boolean success = new EmployeeDAO().updateEmployee(emp);
        
        response.setContentType("text/plain");
        response.getWriter().write(success ? "OK" : "FAIL");
	}

}
