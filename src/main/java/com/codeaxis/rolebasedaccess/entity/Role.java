package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "roles")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_role_id",
                columnDefinition = "BINARY(16)"
        )
)
public class Role extends BaseEntity {

    @Column(name = "role_name", nullable = false)
    private String roleName;

    @Column(name = "role_description")
    private String roleDescription;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    // ROLE NAME

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    // ROLE DESCRIPTION

    public String getRoleDescription() {
        return roleDescription;
    }

    public void setRoleDescription(
            String roleDescription) {

        this.roleDescription = roleDescription;
    }

    // IS ACTIVE

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean active) {
        isActive = active;
    }

    // IS DELETED

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean deleted) {
        isDeleted = deleted;
    }
}