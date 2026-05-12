package com.codeaxis.controller;

import com.codeaxis.dto.ApiResponse;
import com.codeaxis.dto.NotificationRequest;
import com.codeaxis.dto.NotificationResponse;
import com.codeaxis.service.NotificationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @PostMapping
    public ApiResponse<NotificationResponse> createNotification(
            @RequestBody NotificationRequest request
    ) {

        NotificationResponse response =
                notificationService
                        .createNotification(request);

        return ApiResponse
                .<NotificationResponse>builder()
                .status(true)
                .message("Notification created successfully")
                .data(response)
                .build();
    }

    @GetMapping
    public ApiResponse<List<NotificationResponse>> getAllNotifications() {

        List<NotificationResponse> notifications =
                notificationService.getAllNotifications();

        return ApiResponse
                .<List<NotificationResponse>>builder()
                .status(true)
                .message("Notifications fetched successfully")
                .data(notifications)
                .build();
    }

    @GetMapping("/{username}")
    public ApiResponse<List<NotificationResponse>> getNotificationsByUsername(
            @PathVariable String username
    ) {

        List<NotificationResponse> notifications =
                notificationService
                        .getNotificationsByUsername(username);

        return ApiResponse
                .<List<NotificationResponse>>builder()
                .status(true)
                .message("User notifications fetched successfully")
                .data(notifications)
                .build();
    }

    @PutMapping("/{id}/read")
    public ApiResponse<NotificationResponse> markAsRead(
            @PathVariable Long id
    ) {

        NotificationResponse response =
                notificationService.markAsRead(id);

        if (response == null) {

            return ApiResponse
                    .<NotificationResponse>builder()
                    .status(false)
                    .message("Notification not found")
                    .data(null)
                    .build();
        }

        return ApiResponse
                .<NotificationResponse>builder()
                .status(true)
                .message("Notification marked as read")
                .data(response)
                .build();
    }
}