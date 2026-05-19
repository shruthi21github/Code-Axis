package com.codeaxis.service.mail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.codeaxis.service.mail.dto.SendEmailRequestDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class EmailService {

        /*
         * =============================================================================
         * SMTP ENABLE FLAG
         * =============================================================================
         */

        @Value("${app.mail.smtp-enabled}")
        private boolean smtpEnabled;

        /*
         * =============================================================================
         * MAIL CONFIGURATION
         * =============================================================================
         */

        @Value("${spring.mail.username}")
        private String fromEmail;

        /*
         * =============================================================================
         * DEPENDENCIES
         * =============================================================================
         */

        private final JavaMailSender javaMailSender;

        /*
         * =============================================================================
         * SEND EMAIL
         * =============================================================================
         */

        public void sendEmail(
                        SendEmailRequestDto request) {

                /*
                 * ===========================================================================
                 * SMTP DISABLED
                 * ===========================================================================
                 */

                if (!smtpEnabled) {

                        System.out.println("""
                                        
                                        ===========================================================================
                                        SMTP DISABLED - EMAIL NOT SENT
                                        
                                        To      : %s
                                        Subject : %s
                                        
                                        BODY:
                                        
                                        %s
                                        
                                        ===========================================================================
                                        """
                                        .formatted(
                                                        request.getToEmail(),
                                                        request.getSubject(),
                                                        request.getBody()));

                        return;
                }

                /*
                 * ===========================================================================
                 * CREATE MAIL MESSAGE
                 * ===========================================================================
                 */

                SimpleMailMessage message = new SimpleMailMessage();

                message.setFrom(
                                "Fusion5tech <"
                                                + fromEmail
                                                + ">");

                message.setTo(
                                request.getToEmail());

                message.setSubject(
                                request.getSubject());

                message.setText(
                                request.getBody());

                /*
                 * ===========================================================================
                 * SEND EMAIL
                 * ===========================================================================
                 */

                javaMailSender.send(
                                message);

                /*
                 * ===========================================================================
                 * SUCCESS LOG
                 * ===========================================================================
                 */

                System.out.println("""
                                
                                ===========================================================================
                                EMAIL SENT SUCCESSFULLY
                                
                                To      : %s
                                Subject : %s
                                
                                ===========================================================================
                                """
                                .formatted(
                                                request.getToEmail(),
                                                request.getSubject()));
        }
}