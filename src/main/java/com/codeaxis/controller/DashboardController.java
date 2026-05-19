package com.codeaxis.controller; 
 
import com.codeaxis.dto.ApiResponse; 
import com.codeaxis.dto.DashboardStatsResponse; 
import com.codeaxis.service.DashboardService; 
import lombok.RequiredArgsConstructor; 
import org.springframework.http.ResponseEntity; 
import org.springframework.web.bind.annotation.*; 
 
@RestController 
@RequestMapping("/api/dashboard") 
@RequiredArgsConstructor 
public class DashboardController { 
 
    private final DashboardService dashboardService; 
 
    @GetMapping("/stats") 
    public ResponseEntity<?> getStats() { 
 
        DashboardStatsResponse stats = dashboardService.getStats(); 
 
        return ResponseEntity.ok(ApiResponse.builder() 
                .status(true) 
                .message("Dashboard stats fetched successfully") 
                .data(stats) 
                .build()); 
    } 
} 