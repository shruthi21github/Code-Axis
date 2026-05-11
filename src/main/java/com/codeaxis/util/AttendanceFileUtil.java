package com.codeaxis.util;

import com.codeaxis.entity.Attendance;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AttendanceFileUtil {

    private static final String FILE_PATH =
            "src/main/resources/attendance.json";

    private static final ObjectMapper objectMapper =
            new ObjectMapper();

    static {
        objectMapper.findAndRegisterModules();
    }

    public static List<Attendance> readAttendance() {

        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return new ArrayList<>();
        }

        try {
            return objectMapper.readValue(
                    file,
                    new TypeReference<List<Attendance>>() {}
            );
        } catch (IOException e) {
            return new ArrayList<>();
        }
    }

    public static void writeAttendance(
            List<Attendance> attendanceList
    ) {

        try {
            objectMapper.writerWithDefaultPrettyPrinter()
                    .writeValue(
                            new File(FILE_PATH),
                            attendanceList
                    );

        } catch (IOException e) {
            throw new RuntimeException(
                    "Failed to write attendance data"
            );
        }
    }
}
