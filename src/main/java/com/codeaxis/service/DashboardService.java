package com.codeaxis.service;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import com.codeaxis.dto.StatsResponse;
import com.codeaxis.repository.ProjectRepository;
import com.codeaxis.repository.TaskRepository;
import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final ProjectRepository projectRepo;
    private final TaskRepository taskRepo;

    //GET/api/dashboard/stats
    public StatsResponse getStats(){
        Map<String, Object> stats = new HashMap<>();

    //total count
    stats.put("totalprojects", projectRepo.count());
    stats.put("totaltask", taskRepo.count());

    //task status count
    stats.put("todoTasks", 
            taskRepo.findByStatus("TODO").size());
        stats.put("inProgressTasks", 
            taskRepo.findByStatus("IN_PROGRESS").size());
        stats.put("completedTasks", 
            taskRepo.findByStatus("COMPLETED").size());

        return new StatsResponse(
            true, "Dashboard stats", stats);
    }

    // GET/api/dashboard/performance
    public StatsResponse getPerformance() {
        Map<String, Object> performance = new HashMap<>();

        long total = taskRepo.count();
        long completed = taskRepo
            .findByStatus("COMPLETED").size();

        // completion percentage
        double percentage = total == 0 ? 0 :
            ((double) completed / total) * 100;

        performance.put("totalTasks", total);
        performance.put("completedTasks", completed);
        performance.put("completionPercentage",
            Math.round(percentage) + "%");
        performance.put("pendingTasks",
            total - completed);

        return new StatsResponse(
            true, "Performance stats", performance);
    }
}
