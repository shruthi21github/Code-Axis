package codeaxis.api.service.mail;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;

@Component
public class MailStartupValidator
        implements CommandLineRunner {

    @Value("${spring.mail.host}")
    private String host;

    @Value("${spring.mail.port}")
    private int port;

    @Value("${spring.mail.username}")
    private String username;

    @Value("${spring.mail.password}")
    private String password;

    @Override
    public void run(
            String... args)
            throws Exception {

        /*
        ===========================================================================
        CREATE SMTP SESSION
        ===========================================================================
        */

        Properties properties =
                new Properties();

        properties.put(
                "mail.smtp.auth",
                "true");

        properties.put(
                "mail.smtp.ssl.enable",
                "true");

        properties.put(
                "mail.smtp.host",
                host);

        properties.put(
                "mail.smtp.port",
                String.valueOf(port));

        /*
        ===========================================================================
        AUTHENTICATE SMTP CONNECTION
        ===========================================================================
        */

        Session session =
                Session.getInstance(
                        properties,

                        new Authenticator() {

                            @Override
                            protected PasswordAuthentication
                                    getPasswordAuthentication() {

                                return new PasswordAuthentication(
                                        username,
                                        password);
                            }
                        });

        Transport transport =
                session.getTransport(
                        "smtp");

        transport.connect();

        /*
        ===========================================================================
        SMTP AUTH SUCCESS
        ===========================================================================
        */

        System.out.println(
                """
                ===========================================================================
                SMTP AUTHENTICATION SUCCESSFUL

                Host     : %s
                Port     : %d
                Username : %s
                SSL      : ENABLED

                ===========================================================================
                """
                        .formatted(
                                host,
                                port,
                                username));

        transport.close();
    }
}
