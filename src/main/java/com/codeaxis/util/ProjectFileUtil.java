package com.codeaxis.util;

import com.codeaxis.entity.Project;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Component
public class ProjectFileUtil {

    private static final String FILE_PATH =
            "src/main/resources/projects.json";

    private final ObjectMapper objectMapper =
            new ObjectMapper();

    private File getFile() {

        return new File(FILE_PATH);
    }

    public List<Project> readProjects() {

        try {

            File file = getFile();

            if (!file.exists() || file.length() == 0) {
                return new ArrayList<>();
            }

            return objectMapper.readValue(
                    file,
                    new TypeReference<List<Project>>() {}
            );

        } catch (Exception e) {

            e.printStackTrace();

            return new ArrayList<>();
        }
    }

    public void writeProjects(List<Project> projects) {

        try {

            File file = getFile();

            objectMapper
                    .writerWithDefaultPrettyPrinter()
                    .writeValue(file, projects);

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}