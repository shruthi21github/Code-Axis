package com.codeaxis.rolebasedaccess.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "role_permissions")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_role_permission_id",
                columnDefinition = "BINARY(16)"
        )
)
public class RolePermission extends BaseEntity {

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(name = "fk_role_id")
    private Role role;

    @ManyToOne(fetch = FetchType.EAGER)

    @JoinColumn(name = "fk_permission_id")
    private Permission permission;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    // ROLE

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    // PERMISSION

    public Permission getPermission() {
        return permission;
    }

    public void setPermission(
            Permission permission) {

        this.permission = permission;
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