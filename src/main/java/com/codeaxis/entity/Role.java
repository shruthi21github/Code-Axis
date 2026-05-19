package com.codeaxis.entity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

@Entity
@Table(name = "roles")

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Role {

    /*
     * ===========================================================================
     * PRIMARY KEY
     * ===========================================================================
     */

    @Id
    @JdbcTypeCode(SqlTypes.BINARY)
    @Column(name = "pk_role_id", columnDefinition = "BINARY(16)", nullable = false)
    private UUID pkRoleId;

    /*
     * ===========================================================================
     * ROLE DETAILS
     * ===========================================================================
     */

    @Column(name = "role_name", nullable = false, unique = true, length = 100)
    private String roleName;

    @Column(name = "role_description", length = 255)
    private String roleDescription;

    @Column(name = "role_level", nullable = false)
    private Integer roleLevel;

    /*
     * ===========================================================================
     * STATUS
     * ===========================================================================
     */

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt;

    /*
     * ===========================================================================
     * AUDIT
     * ===========================================================================
     */

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @JdbcTypeCode(SqlTypes.BINARY)
    @Column(name = "created_by", columnDefinition = "BINARY(16)")
    private UUID createdBy;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @JdbcTypeCode(SqlTypes.BINARY)
    @Column(name = "updated_by", columnDefinition = "BINARY(16)")
    private UUID updatedBy;

    /*
     * ===========================================================================
     * REVERSE RELATIONSHIPS
     * ===========================================================================
     */

    @JsonIgnore
    @OneToMany(mappedBy = "fkRoleId", fetch = FetchType.LAZY)
    private List<User> users;
}
