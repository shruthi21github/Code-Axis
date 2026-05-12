package com.codeaxis.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notification {

    private Long id;

    private String title;

    private String message;

    private String type;

    private boolean isRead;

    private String username;

    private LocalDateTime createdAt;
}