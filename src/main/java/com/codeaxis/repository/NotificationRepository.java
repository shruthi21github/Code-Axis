package com.codeaxis.repository;

import com.codeaxis.entity.Notification;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Repository
public class NotificationRepository {

    private final List<Notification> notifications =
            new ArrayList<>();

    private final AtomicLong counter =
            new AtomicLong(1);

    public Notification save(
            Notification notification
    ) {

        notification.setId(
                counter.getAndIncrement()
        );

        notifications.add(notification);

        return notification;
    }

    public List<Notification> findAll() {

        return notifications;
    }

    public List<Notification> findByUsername(
            String username
    ) {

        return notifications
                .stream()
                .filter(notification ->
                        notification
                                .getUsername()
                                .equalsIgnoreCase(username)
                )
                .collect(Collectors.toList());
    }

    public Notification findById(
            Long id
    ) {

        return notifications
                .stream()
                .filter(notification ->
                        notification.getId().equals(id)
                )
                .findFirst()
                .orElse(null);
    }
}
