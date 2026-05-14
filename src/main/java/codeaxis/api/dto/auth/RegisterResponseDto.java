package codeaxis.api.dto.auth;

import java.time.LocalDateTime;

public class RegisterResponseDto
{
    private String userId;

    private String roleId;

    private String username;

    private String email;

    private String roleName;

    private Boolean isEmailVerified;

    private Boolean isActive;

    private LocalDateTime createdAt;

    public String getUserId()
    {
        return userId;
    }

    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    public String getRoleId()
    {
        return roleId;
    }

    public void setRoleId(String roleId)
    {
        this.roleId = roleId;
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername(String username)
    {
        this.username = username;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getRoleName()
    {
        return roleName;
    }

    public void setRoleName(String roleName)
    {
        this.roleName = roleName;
    }

    public Boolean getIsEmailVerified()
    {
        return isEmailVerified;
    }

    public void setIsEmailVerified(Boolean isEmailVerified)
    {
        this.isEmailVerified = isEmailVerified;
    }

    public Boolean getIsActive()
    {
        return isActive;
    }

    public void setIsActive(Boolean isActive)
    {
        this.isActive = isActive;
    }

    public LocalDateTime getCreatedAt()
    {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt)
    {
        this.createdAt = createdAt;
    }
}
