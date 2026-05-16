package codeaxis.api.service.mail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import codeaxis.api.service.mail.dto.SendEmailRequestDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class EmailService {

        @Value("${spring.mail.username}")
        private String fromEmail;

        private final JavaMailSender javaMailSender;

        public void sendEmail(
                        SendEmailRequestDto request) {

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
        }
}
