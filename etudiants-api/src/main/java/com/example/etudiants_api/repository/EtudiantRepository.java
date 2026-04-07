package com.example.etudiantsapi.repository;

import com.example.etudiants_api.model.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {
}