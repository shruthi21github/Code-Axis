package com.codeaxis.rolebasedaccess.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/public/home")
    public String publicAccess() {
        return "This is public content. Anyone can see this.";
    }

    @GetMapping("/admin/dashboard")
    public String adminAccess() {
        return "Admin Dashboard: Only users with the ADMIN role can see this.";
    }

    @GetMapping("/employee/portal")
    public String employeeAccess() {
        return "Employee Portal: Accessible by EMPLOYEE and ADMIN.";
    }

    @GetMapping("/client/resources")
    public String clientAccess() {
        return "Client Resources: Accessible by CLIENT and ADMIN.";
    }
}
