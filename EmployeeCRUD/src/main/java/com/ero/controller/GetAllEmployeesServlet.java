package com.ero.controller;

import com.google.gson.Gson;
import com.ero.DAO.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ero.model.Employee;




import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/getEmployees")
public class GetAllEmployeesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO dao = new EmployeeDAO();
        List<Employee> employees = dao.getAllEmployees();

        // Convert to JSON using Gson
        Gson gson = new Gson();
        String json = gson.toJson(employees);

        // Set response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}