package com.codeaxis.service.impl;

import com.codeaxis.dto.AssignStudentsRequest;
import com.codeaxis.entity.Project;
import com.codeaxis.service.ProjectService;
import com.codeaxis.service.StudentService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ProjectServiceImpl
        implements ProjectService {

    private final StudentService studentService;

    private final String FILE_PATH =
            "src/main/resources/data/projects.json";

    private final ObjectMapper objectMapper =
            new ObjectMapper();

    @Override
    public Project createProject(Project project) {

        List<Project> projects =
                readProjectsFromFile();

        /*
         * Safety check
         */
        if (projects == null) {

            projects = new ArrayList<>();
        }

        /*
         * Generate project ID
         */
        project.setId(
                (long) (projects.size() + 1));

        /*
         * Prevent null assignedStudents
         */
        if (project.getAssignedStudents() == null) {

            project.setAssignedStudents(
                    new ArrayList<>());
        }

        projects.add(project);

        writeProjectsToFile(projects);

        return project;
    }

    @Override
    public List<Project> getAllProjects() {

        return readProjectsFromFile();
    }

    @Override
    public Project assignStudentsToProject(
            AssignStudentsRequest request) {

        List<Project> projects =
                readProjectsFromFile();

        Project foundProject = null;

        for (Project project : projects) {

            if (project.getId()
                    .equals(request.getProjectId())) {

                foundProject = project;
                break;
            }
        }

        /*
         * Validate project exists
         */
        if (foundProject == null) {

            throw new RuntimeException(
                    "Project not found");
        }

        /*
         * Remove duplicate student IDs
         */
        Set<Long> uniqueStudentIds =
                new HashSet<>(
                        request.getStudentIds());

        /*
         * Validate student exists
         */
        for (Long studentId : uniqueStudentIds) {

            boolean exists =
                    studentService
                            .studentExists(studentId);

            if (!exists) {

                throw new RuntimeException(
                        "Student ID not found: "
                                + studentId);
            }
        }

        /*
         * Prevent duplicate assignment
         */
        List<Long> alreadyAssigned =
                foundProject
                        .getAssignedStudents();

        for (Long studentId : uniqueStudentIds) {

            if (alreadyAssigned
                    .contains(studentId)) {

                throw new RuntimeException(
                        "Student already assigned: "
                                + studentId);
            }
        }

        /*
         * Add students
         */
        alreadyAssigned.addAll(uniqueStudentIds);

        foundProject.setAssignedStudents(
                alreadyAssigned);

        writeProjectsToFile(projects);

        return foundProject;
    }

    /*
     * Read projects.json
     */
    private List<Project> readProjectsFromFile() {

        try {

            File file = new File(FILE_PATH);

            /*
             * Create file if not exists
             */
            if (!file.exists()) {

                file.getParentFile().mkdirs();

                file.createNewFile();

                objectMapper.writeValue(
                        file,
                        new ArrayList<Project>());

                return new ArrayList<>();
            }

            /*
             * Handle empty file
             */
            if (file.length() == 0) {

                return new ArrayList<>();
            }

            return objectMapper.readValue(
                    file,
                    new TypeReference<List<Project>>() {});
        }

        catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                    "Failed to read projects.json");
        }
    }

    /*
     * Write projects.json
     */
    private void writeProjectsToFile(
            List<Project> projects) {

        try {

            objectMapper
                    .writerWithDefaultPrettyPrinter()
                    .writeValue(
                            new File(FILE_PATH),
                            projects);

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                    "Failed to write projects.json");
        }
    }
}