package com.codeaxis.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "permissions")

@AttributeOverride(
        name = "id",
        column = @Column(
                name = "pk_permission_id",
                columnDefinition = "BINARY(16)"
        )
)
public class Permission extends BaseEntity {

    @Column(name = "module_name")
    private String moduleName;

    @Column(name = "action_name")
    private String actionName;

    @Column(name = "permission_name")
    private String permissionName;

    @Column(name = "permission_description")
    private String permissionDescription;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    // MODULE NAME

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    // ACTION NAME

    public String getActionName() {
        return actionName;
    }

    public void setActionName(String actionName) {
        this.actionName = actionName;
    }

    // PERMISSION NAME

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(
            String permissionName) {

        this.permissionName = permissionName;
    }

    // PERMISSION DESCRIPTION

    public String getPermissionDescription() {
        return permissionDescription;
    }

    public void setPermissionDescription(
            String permissionDescription) {

        this.permissionDescription =
                permissionDescription;
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