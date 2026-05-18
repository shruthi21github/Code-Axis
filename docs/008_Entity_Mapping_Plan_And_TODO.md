# 008_Entity_Mapping_Plan_And_TODO

## Objective

Implement full database entity mapping in the Java Spring Boot backend using JPA/Hibernate.

Each MySQL table will have:

* One entity class
* Proper primary key mapping
* Foreign key relationship mapping
* Reverse relationship mapping
* IntelliSense join navigation support
* Consistent naming conventions
* Audit column support
* Lazy loading configuration

---

# Architecture Goal

MySQL Tables
→
JPA Entity Classes
→
Hibernate Relationship Navigation
→
Repository IntelliSense + JPQL joins

---

# Existing Entity Files To Review

## Current Files

```text
src/main/java/codeaxis/api/entity/User.java
src/main/java/codeaxis/api/entity/Role.java
src/main/java/codeaxis/api/entity/EmailVerificationToken.java
```

## Review Goals

* Verify table mappings
* Verify column mappings
* Verify relationship mappings
* Add missing FK relationships
* Add reverse navigation collections
* Standardize annotations
* Standardize fetch strategies
* Standardize naming

---

# Entity Standards

## Base Mapping

Every entity should contain:

* `@Entity`
* `@Table(name = "...")`
* `@Id`
* `@Column(name = "...")`

---

# Relationship Standards

## Parent → Child

```java
@OneToMany(mappedBy = "role", fetch = FetchType.LAZY)
private List<User> users;
```

## Child → Parent

```java
@ManyToOne(fetch = FetchType.LAZY)
@JoinColumn(name = "fk_role_id")
private Role role;
```

---

# Fetch Strategy

Default plan:

* `LAZY` for relationships
* Avoid unnecessary eager loading
* Prevent recursive object loading

---

# JSON Serialization Safety

To avoid circular serialization issues:

Potential usage:

* `@JsonIgnore`
* `@JsonManagedReference`
* `@JsonBackReference`

Decision will be finalized during implementation.

---

# Lombok Decision

## Current Status

Lombok dependency already exists in pom.xml.

## Planned Approach

Use Lombok for scalability and cleaner entities.

Expected annotations:

```java
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
```

Benefits:

* Less boilerplate
* Cleaner entities
* Easier maintenance
* Industry standard in Spring Boot projects

---

# Package Structure

```text
src/main/java/codeaxis/api/entity/
```

---

# Planned Entity Creation Workflow

For EACH table:

1. Review MySQL table structure
2. Create entity skeleton
3. Add PK mapping
4. Add column mappings
5. Add FK relationships
6. Add reverse relationships
7. Add indexes/constraints if needed
8. Validate naming consistency
9. Validate IntelliSense relationship navigation
10. Move to next table

---

# TODO Progress Tracker

## Phase 1 — Existing Entity Refactor

* [ ] User.java review
* [ ] Role.java review
* [ ] EmailVerificationToken.java review

---

## Phase 2 — Security/Auth Tables

* [ ] Permission.java
* [ ] RolePermission.java
* [ ] UserSession.java
* [ ] RefreshToken.java (if exists)
* [ ] PasswordResetToken.java (if exists)

---

## Phase 3 — Domain Tables

* [ ] Student.java
* [ ] Employee.java
* [ ] Client.java
* [ ] Additional domain entities

---

## Phase 4 — Validation

* [ ] IntelliSense relationship validation
* [ ] JPQL join testing
* [ ] Circular serialization testing
* [ ] Lazy loading validation
* [ ] Naming consistency validation

---

# Important Rules

* One entity at a time
* One relationship at a time
* No assumptions
* Validate each entity before moving forward
* Keep entity names singular
* Keep table names matching MySQL schema

---

# Expected Final Result

The backend should support:

* IntelliSense joins
* Relationship navigation
* Repository query joins
* JPQL joins
* Cleaner service layer code
* Easier DTO creation
* Easier API expansion

--------

