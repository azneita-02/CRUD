<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <!-- jQuery and SweetAlert2 CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        table {
            width: 90%;
            margin: 20px auto;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        button {
            margin: 5px;
        }
    </style>
</head>
<body>

    <h2 style="text-align: center;">Employee Records</h2>
    <div style="text-align: center;">
        <button id="addBtn">Add Employee</button>
    </div>

    <table id="employeeTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Employee ID</th>
                <th>Name</th>
                <th>Hired Date</th>
                <th>Age</th>
                <th>Job Level</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Table data will be populated here -->
        </tbody>
    </table>

<script>
    function loadEmployees() {
        $.ajax({
            url: 'getEmployees',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                console.log("Loaded employees:", data);
                const tbody = $('#employeeTable tbody');
                tbody.empty();
                console.log(data);	
                
                data.forEach(emp => {
                	console.log(emp.employeeId + "sdaddas");
                	const row = 
                	    "<tr>" +
                	        "<td>" + emp.employeeEroId + "</td>" +
                	        "<td>" + emp.employeeId + "</td>" +
                	        "<td>" + emp.firstName + " " + emp.lastName + "</td>" +
                	        "<td>" + emp.hiredDate + "</td>" +
                	        "<td>" + emp.age + "</td>" +
                	        "<td>" + emp.jobLevel + "</td>" +
                	        "<td>" +
                	            "<button class='editBtn' data-id='" + emp.employeeEroId + "'>Edit</button> " +
                	            "<button class='deleteBtn' data-id='" + emp.employeeEroId + "'>Delete</button>" +
                	        "</td>" +
                	    "</tr>";
                    tbody.append(row);
                });
            },
            error: function(err) {
                console.error("Error loading employees:", err);
                Swal.fire("Error", "Failed to load employee data.", "error");
            }
        });
    }

    $('#addBtn').click(function () {
        Swal.fire({
            title: 'Add Employee',
            html:
                `<input id="empId" class="swal2-input" placeholder="Employee ID">` +
                `<input id="firstName" class="swal2-input" placeholder="First Name">` +
                `<input id="lastName" class="swal2-input" placeholder="Last Name">` +
                `<input id="hiredDate" class="swal2-input" placeholder="Hired Date (25-MAY-26)">` +
                `<input id="age" class="swal2-input" type="number" placeholder="Age">` +
                `<input id="jobLevel" class="swal2-input" type="number" placeholder="Job Level">`,
            focusConfirm: false,
            showCancelButton: true,
            preConfirm: () => {
                return {
                    employeeId: document.getElementById('empId').value,
                    firstName: document.getElementById('firstName').value,
                    lastName: document.getElementById('lastName').value,
                    hiredDate: document.getElementById('hiredDate').value,
                    age: document.getElementById('age').value,
                    jobLevel: document.getElementById('jobLevel').value
                };
            }
        }).then(result => {
            if (result.isConfirmed) {
                $.post('addEmployee', result.value, function(response) {
                    if (response === 'success') {
                        Swal.fire('Success!', 'Employee added.', 'success');
                        loadEmployees();
                    } else {
                        Swal.fire('Error', 'Failed to add employee.', 'error');
                    }
                });
            }
        });
    });

    $(document).ready(() => {
        loadEmployees();
    });
</script>

</body>
</html>
