package com.codeaxis.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.codeaxis.dto.DashboardStatsResponse;
import com.codeaxis.entity.ProjectStatus;
import com.codeaxis.repository.EmployeeRepository;
import com.codeaxis.repository.ProjectRepository;
import com.codeaxis.repository.ProjectStatusRepository;
import com.codeaxis.repository.TaskRepository;
import com.codeaxis.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {

        private final UserRepository userRepository;

        private final EmployeeRepository employeeRepository;

        private final ProjectRepository projectRepository;

        private final ProjectStatusRepository projectStatusRepository;

        private final TaskRepository taskRepository;

        /*
         * ===========================================================================
         * GET DASHBOARD STATS
         * ===========================================================================
         */

        @Transactional(readOnly = true)
        public DashboardStatsResponse getStats() {

                /*
                 * ===============================================================
                 * USERS
                 * ===============================================================
                 */

                long totalUsers = userRepository.count();

                /*
                 * ===============================================================
                 * EMPLOYEES
                 * ===============================================================
                 */

                long totalEmployees = employeeRepository
                                .countByIsDeletedFalse();

                long activeEmployees = employeeRepository
                                .countByIsActiveTrue();

                /*
                 * ===============================================================
                 * PROJECTS
                 * ===============================================================
                 */

                long totalProjects = projectRepository
                                .countByIsDeletedFalse();

                ProjectStatus activeStatus = projectStatusRepository
                                .findByStatusNameIgnoreCase(
                                                "ACTIVE")
                                .orElse(
                                                null);

                long activeProjects = activeStatus != null
                                ? projectRepository
                                                .countByFkProjectStatusAndIsDeletedFalse(
                                                                activeStatus)
                                : 0;

                ProjectStatus completedStatus = projectStatusRepository
                                .findByStatusNameIgnoreCase(
                                                "COMPLETED")
                                .orElse(
                                                null);

                long completedProjects = completedStatus != null
                                ? projectRepository
                                                .countByFkProjectStatusAndIsDeletedFalse(
                                                                completedStatus)
                                : 0;

                /*
                 * ===============================================================
                 * TASKS
                 * ===============================================================
                 */

                long totalTasks = taskRepository
                                .countByIsDeletedFalse();

                long todoTasks = taskRepository
                                .countByFkTaskStatusIdStatusNameIgnoreCaseAndIsDeletedFalse(
                                                "TODO");

                long inProgressTasks = taskRepository
                                .countByFkTaskStatusIdStatusNameIgnoreCaseAndIsDeletedFalse(
                                                "IN_PROGRESS");

                long doneTasks = taskRepository
                                .countByFkTaskStatusIdStatusNameIgnoreCaseAndIsDeletedFalse(
                                                "DONE");

                long blockedTasks = taskRepository
                                .countByFkTaskStatusIdStatusNameIgnoreCaseAndIsDeletedFalse(
                                                "BLOCKED");

                /*
                 * ===============================================================
                 * RETURN RESPONSE
                 * ===============================================================
                 */

                return DashboardStatsResponse.builder()
                                .totalUsers(
                                                totalUsers)
                                .totalEmployees(
                                                totalEmployees)
                                .activeEmployees(
                                                activeEmployees)
                                .totalProjects(
                                                totalProjects)
                                .activeProjects(
                                                activeProjects)
                                .completedProjects(
                                                completedProjects)
                                .totalTasks(
                                                totalTasks)
                                .todoTasks(
                                                todoTasks)
                                .inProgressTasks(
                                                inProgressTasks)
                                .doneTasks(
                                                doneTasks)
                                .blockedTasks(
                                                blockedTasks)
                                .build();
        }
}
