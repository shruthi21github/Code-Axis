package com.codeaxis.service;

import com.codeaxis.dto.NotificationRequest;
import com.codeaxis.dto.NotificationResponse;
import com.codeaxis.entity.Notification;
import com.codeaxis.repository.NotificationRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    public NotificationResponse createNotification(
            NotificationRequest request
    ) {

        Notification notification =
                Notification.builder()
                        .title(request.getTitle())
                        .message(request.getMessage())
                        .type(request.getType())
                        .username(request.getUsername())
                        .isRead(false)
                        .createdAt(LocalDateTime.now())
                        .build();

        Notification savedNotification =
                notificationRepository.save(notification);

        return mapToResponse(savedNotification);
    }

    public List<NotificationResponse> getAllNotifications() {

        return notificationRepository
                .findAll()
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public List<NotificationResponse> getNotificationsByUsername(
            String username
    ) {

        return notificationRepository
                .findByUsername(username)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public NotificationResponse markAsRead(
            Long id
    ) {

        Notification notification =
                notificationRepository.findById(id);

        if (notification == null) {
            return null;
        }

        notification.setRead(true);

        return mapToResponse(notification);
    }

    private NotificationResponse mapToResponse(
            Notification notification
    ) {

        return NotificationResponse
                .builder()
                .id(notification.getId())
                .title(notification.getTitle())
                .message(notification.getMessage())
                .type(notification.getType())
                .isRead(notification.isRead())
                .username(notification.getUsername())
                .createdAt(notification.getCreatedAt())
                .build();
    }
}
