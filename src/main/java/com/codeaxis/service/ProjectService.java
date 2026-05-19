package com.codeaxis.service; 
 
import com.codeaxis.dto.ProjectRequest; 
import com.codeaxis.dto.ProjectResponse; 
import com.codeaxis.entity.Project; 
import com.codeaxis.entity.ProjectStatus; 
import com.codeaxis.repository.ProjectRepository; 
import com.codeaxis.repository.ProjectStatusRepository; 
import lombok.RequiredArgsConstructor; 
import org.springframework.stereotype.Service; 
import org.springframework.transaction.annotation.Transactional; 
 
@Service 
@RequiredArgsConstructor 
public class ProjectService { 
 
    private final ProjectRepository projectRepository; 
    private final ProjectStatusRepository projectStatusRepository; 
 
    @Transactional 
    public ProjectResponse createProject(ProjectRequest request) { 
 
        // Validate duplicate project code 
        if (projectRepository.existsByProjectCode(request.getProjectCode())) { 
            throw new RuntimeException( 
                "Project code already exists: " + request.getProjectCode()); 
        } 
 
        // Fetch status from project_statuses table 
        String statusName = (request.getStatusName() != null 
                && !request.getStatusName().isBlank()) 
                ? request.getStatusName() : "PLANNING"; 
 
        ProjectStatus status = projectStatusRepository 
                .findByStatusNameIgnoreCase(statusName) 
                .orElseThrow(() -> new RuntimeException( 
                        "Project status not found: " + statusName)); 
 
        // Build and save Project entity 
        Project project = new Project(); 
        project.setProjectCode(request.getProjectCode().trim().toUpperCase()); 
        project.setProjectName(request.getProjectName()); 
        project.setProjectDescription(request.getProjectDescription()); 
        project.setFkProjectStatus(status); 
        project.setStartAt(request.getStartAt()); 
        project.setDeadlineAt(request.getDeadlineAt()); 
        project.setActive(true); 
        project.setDeleted(false); 
 
        Project saved = projectRepository.save(project); 
 
        return mapToResponse(saved); 
    } 
 
    // Map entity → DTO (no entity exposed outside service) 
    private ProjectResponse mapToResponse(Project project) { 
        ProjectResponse res = new ProjectResponse(); 
        res.setProjectId(project.getPkProjectId()); 
        res.setProjectCode(project.getProjectCode()); 
        res.setProjectName(project.getProjectName()); 
        res.setProjectDescription(project.getProjectDescription()); 
        res.setStatusName(project.getFkProjectStatus().getStatusName()); 
        res.setStartAt(project.getStartAt()); 
        res.setDeadlineAt(project.getDeadlineAt()); 
        res.setCreatedAt(project.getCreatedAt()); 
        return res; 
    } 
} 