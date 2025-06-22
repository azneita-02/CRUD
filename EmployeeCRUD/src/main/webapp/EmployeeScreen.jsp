<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <!-- jQuery and SweetAlert2 CDN -->
    <!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>

<!-- jQuery (already included) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- SweetAlert2 (already included) -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- DataTables JS -->
<script type="text/javascript" src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <style>
    /*
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
        */
        button {
            margin: 5px;
        }
        
        .colored-toast.swal2-icon-success {
  background-color: #a5dc86 !important;
}

.colored-toast.swal2-icon-error {
  background-color: #f27474 !important;
}

.colored-toast.swal2-icon-warning {
  background-color: #f8bb86 !important;
}

.colored-toast.swal2-icon-info {
  background-color: #3fc3ee !important;
}

.colored-toast.swal2-icon-question {
  background-color: #87adbd !important;
}

.colored-toast .swal2-title {
  color: white;
}

.colored-toast .swal2-close {
  color: white;
}

.colored-toast .swal2-html-container {
  color: white;
}
    </style>
</head>
<body>

    <h2 style="text-align: center;">Employee Records</h2>
    <div style="text-align: center;">
        <button id="addBtn">Add Employee</button>
    </div>

    <table id="employeeTable" class="display">
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
    <!--    <tbody>
             Table data will be populated here 
        </tbody>-->
    </table>

<script>
/*
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

*/
	
let dataTable;

function loadEmployees() {
    $.ajax({
        url: 'getEmployees',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log("Loaded employees:", data);

            if (!$.fn.DataTable.isDataTable('#employeeTable')) {
                // First time: initialize the DataTable
                dataTable = $('#employeeTable').DataTable({
                    data: data,
                    columns: [
                        { data: 'employeeEroId' },
                        { data: 'employeeId' },
                        {
                            data: null,
                            render: function (data, type, row) {
                                return row.firstName + ' ' + row.lastName;
                            }
                        },
                        { data: 'hiredDate' },
                        { data: 'age' },
                        { data: 'jobLevel' },
                        {
                            data: null,
                            render: function (data, type, row) {
                                return `
                                    <button class="editBtn" data-id="${row.employeeEroId}">Edit</button>
                                    <button class="deleteBtn" data-id="${row.employeeEroId}">Delete</button>
                                `;
                            }
                        }
                    ]
                });
            } else {
                // On refresh: clear and add new data
                dataTable.clear().rows.add(data).draw();
            }
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
                        //Swal.fire('Success!', 'Employee added.', 'success');
                    	const Toast = Swal.mixin({
                    		  toast: true,
                    		  position: 'center',
                    		  iconColor: 'white',
                    		  customClass: {
                    		    popup: 'colored-toast',
                    		  },
                    		  showConfirmButton: false,
                    		  timer: 1500,
                    		  timerProgressBar: true,
                    		})

                    		;(async () => {
                    		  await Toast.fire({
                    		    icon: 'success',
                    		    title: 'Employee added successfully!',
                    		  })
                    		})()

                        loadEmployees();
                    } else {
                        Swal.fire('Error', 'Failed to add employee.', 'error');
                    }
                });
            }
        }); 
    });
    
 // When any element with class 'editBtn' is clicked
    $(document).on("click", ".editBtn", function () {
        // Get the closest table row of the clicked button
        var row = $(this).closest("tr");

        // Get the employee ID from the 'data-id' attribute
        var id = $(this).data("id");

        // Get all values from the table row (from each <td>)
        var employeeId = row.find("td:eq(1)").text().trim(); // Employee ID column
        var fullName = row.find("td:eq(2)").text().trim();   // Full name column
        var nameParts = fullName.split(" ");                 // Split into first and last name
        var firstName = nameParts[0];
        var lastName = nameParts.slice(1).join(" ");         // Join the rest as last name
        var hiredDate = row.find("td:eq(3)").text().trim();  // Hired date column
        var age = row.find("td:eq(4)").text().trim();        // Age column
        var jobLevel = row.find("td:eq(5)").text().trim();   // Job level column

        // Show a SweetAlert2 modal with input fields pre-filled
        Swal.fire({
            title: "Edit Employee",
            html:
                '<input id="swal-employeeId" class="swal2-input" placeholder="Employee ID" value="' + employeeId + '">' +
                '<input id="swal-firstName" class="swal2-input" placeholder="First Name" value="' + firstName + '">' +
                '<input id="swal-lastName" class="swal2-input" placeholder="Last Name" value="' + lastName + '">' +
                '<input id="swal-hiredDate" type="date" class="swal2-input" value="' + convertToDateInput(hiredDate) + '">' +
                '<input id="swal-age" type="number" class="swal2-input" placeholder="Age" value="' + age + '">' +
                '<input id="swal-jobLevel" type="number" class="swal2-input" placeholder="Job Level" value="' + jobLevel + '">',
            showCancelButton: true,  // Show cancel button
            focusConfirm: false,
            preConfirm: function () {
                // Get input values from the modal before confirming
                return {
                    employeeEroId: id,
                    employeeId: $('#swal-employeeId').val(),
                    firstName: $('#swal-firstName').val(),
                    lastName: $('#swal-lastName').val(),
                    hiredDate: $('#swal-hiredDate').val(),
                    age: $('#swal-age').val(),
                    jobLevel: $('#swal-jobLevel').val()
                };
            }
        }).then(function (result) {
            // If the user clicked "Confirm"
            if (result.isConfirmed) {
                var updatedEmployee = result.value;

                // Send AJAX request to update the employee
                $.ajax({
                    url: 'updateEmployee',
                    method: 'POST',
                    data: updatedEmployee,
                    success: function () {
                        Swal.fire("Success", "Employee updated successfully!", "success");
                        loadEmployees(); // Refresh table
                    },
                    error: function () {
                        Swal.fire("Error", "Something went wrong while updating.", "error");
                    }
                });
            }
        });
    });

    // Convert "May 26, 2025" to "2025-05-26" format for input type="date"
    function convertToDateInput(textDate) {
        var date = new Date(textDate);
        return date.toISOString().split('T')[0];
    }


    $(document).ready(() => {
        loadEmployees();
    });
</script>

</body>
</html>
