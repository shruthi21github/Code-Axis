package com.codeaxis.service;

import com.codeaxis.dto.*;
import com.codeaxis.entity.Project;
import com.codeaxis.repository.ProjectRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepo;

    // Create
    public ProjectResponse create(ProjectRequest req) {
        Project p = new Project();
        p.setName(req.getName());
        p.setDescription(req.getDescription());
        p.setStatus(req.getStatus());
        p.setStartDate(LocalDate.parse(req.getStartDate()));
        p.setDeadline(LocalDate.parse(req.getDeadline()));
        projectRepo.save(p);
        return new ProjectResponse(
            true, "Project created", p);
    }

    // Get All
    public ProjectResponse getAll() {
        List<Project> list = projectRepo.findAll();
        return new ProjectResponse(
            true, "Success", list);
    }

    // Update
    public ProjectResponse update(
            Long id, ProjectRequest req) {
        Project p = projectRepo.findById(id)
            .orElseThrow(() ->
                new RuntimeException("Project not found"));
        p.setName(req.getName());
        p.setDescription(req.getDescription());
        p.setStatus(req.getStatus());
        p.setStartDate(LocalDate.parse(req.getStartDate()));
        p.setDeadline(LocalDate.parse(req.getDeadline()));
        projectRepo.save(p);
        return new ProjectResponse(
            true, "Project updated", p);
    }
}