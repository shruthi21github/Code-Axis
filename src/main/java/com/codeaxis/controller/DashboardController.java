package com.codeaxis.controller;

import lombok.RequiredArgsConstructor;

import com.codeaxis.dto.StatsResponse;
import com.codeaxis.service.DashboardService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
public class DashboardController {
    private final DashboardService dashboardService;

    // GET/api/dashboard/stats
    @GetMapping("/stats")
    public ResponseEntity<StatsResponse> getStats() {
        return ResponseEntity.ok(
            dashboardService.getStats());
    }

    // GET/api/dashboard/performance
    @GetMapping("/performance")
    public ResponseEntity<StatsResponse> getPerformance() {
        return ResponseEntity.ok(
            dashboardService.getPerformance());
    }
}
