Projet Étudiants — Spring Boot & DevOps

Description

Ce projet consiste à développer une application de gestion des étudiants en utilisant **Spring Boot**, puis à l’enrichir avec des pratiques **DevOps modernes** : Docker, Kubernetes (K3S), tests BDD, cache Redis et gestion de projet avec Jira.

---

Architecture du projet

```
/projet-etudiants/
├── api-spring-boot/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/etudiants/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── repository/
│   │   │   │   ├── entity/
│   │   │   │   ├── dto/
│   │   │   │   ├── mapper/
│   │   │   │   └── config/
│   │   │   └── resources/
│   │   │       └── static/index.html
│   │   └── test/
│   │       └── resources/features/etudiant.feature
│   ├── Dockerfile
│   └── pom.xml
├── k8s/
│   ├── etudiant-deployment.yaml
│   └── postgres-deployment.yaml
└── docker-compose.yml
```

---

Fonctionnalités principales

API REST

* Gestion complète des étudiants (CRUD)
* Gestion des départements (CRUD)
* Filtrage par année d’inscription

Logique métier

* Méthode `age()` pour calculer l’âge d’un étudiant

Interface Web

* Page `index.html` avec appel `fetch()` pour afficher les étudiants

Tests BDD (Cucumber)

* Test du calcul d’âge avec syntaxe Gherkin

Docker

* Image Docker du microservice publiée sur Docker Hub

Kubernetes (K3S)

* Déploiement avec :

  * PostgreSQL
  * API Spring Boot

Cache Redis

* Mise en cache des endpoints avec `@Cacheable`
* Invalidation avec `@CacheEvict`

Documentation API

* Swagger disponible via :

```
http://localhost:8080/swagger-ui.html
```

Gestion des erreurs

* Gestion globale avec `@RestControllerAdvice`
* Codes HTTP :

  * 404 Not Found
  * 400 Bad Request
  * 500 Internal Server Error

---

Exemple de test BDD

```gherkin
Feature: Calcul de l'âge d'un étudiant

Scenario: Étudiant né il y a 22 ans
Given un étudiant avec la date de naissance "2002-04-07"
When on calcule son âge
Then l'âge retourné doit être 23
```

---

Docker

Build de l’image

```
docker build -t <username>/etudiant-service:1.0 .
```

Push vers Docker Hub

```
docker push <username>/etudiant-service:1.0
```

---

Kubernetes (K3S)

Déploiement

```
kubectl apply -f k8s/postgres-deployment.yaml
kubectl apply -f k8s/etudiant-deployment.yaml
```

Accès au service

```
kubectl port-forward service/etudiant-service 8081:8080
```

Puis ouvrir :

```
http://localhost:8081
```

---

Base de données

* PostgreSQL utilisé
* Configuration via variables d’environnement
* Génération automatique du schéma :

```
spring.jpa.hibernate.ddl-auto=update
```

---

Cache Redis

* Activation avec `@EnableCaching`
* Exemple :

```java
@Cacheable("etudiants")
public List<EtudiantDTO> findAll() { ... }

@CacheEvict(value = "etudiants", allEntries = true)
public EtudiantDTO save(EtudiantDTO dto) { ... }
```

---

Jira (Gestion Agile)

Epic

* Gestion des Étudiants

Sprint 1 — Partie 1

* API REST de base
* Dockerisation

Sprint 2 — Partie 2

* Méthode `age()` + tests BDD
* Cache Redis
* Kubernetes
* Swagger

---

Bonnes pratiques appliquées

* Architecture en couches (Controller / Service / Repository)
* Utilisation de DTO + Mapper
* Séparation des responsabilités
* Tests BDD
* Déploiement conteneurisé

---

Auteur

Projet réalisé par **Hanin Hajyoussef** dans le cadre du module DevOps.

---
