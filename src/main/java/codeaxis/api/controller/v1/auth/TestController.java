package codeaxis.api.controller.v1.auth;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController
{
    @GetMapping("/test")
    public String test()
    {
        return "ok";
    }
}
