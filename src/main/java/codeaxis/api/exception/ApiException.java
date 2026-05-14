package codeaxis.api.exception;

public class ApiException
extends RuntimeException
{
    public ApiException(String message)
    {
        super(message);
    }
}
