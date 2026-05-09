package com.codeaxis.dto;

import com.codeaxis.entity.Project;

public class ProjectResponse {

    private boolean status;
    private String message;
    private Project data;

    public ProjectResponse() {
    }

    public ProjectResponse(boolean status, String message, Project data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Project getData() {
        return data;
    }

    public void setData(Project data) {
        this.data = data;
    }
}