package com.codeaxis.service;

import com.codeaxis.dto.AssignStudentsRequest;
import com.codeaxis.entity.Project;

import java.util.List;

public interface ProjectService {

    Project createProject(Project project);

    List<Project> getAllProjects();

    Project assignStudentsToProject(
            AssignStudentsRequest request);
}