package com.example.etudiants_api.service;

import com.example.etudiants_api.model.Etudiant;
import com.example.etudiantsapi.repository.EtudiantRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EtudiantService {

    private final EtudiantRepository repository;

    public EtudiantService(EtudiantRepository repository) {
        this.repository = repository;
    }

    public List<Etudiant> getAll() {
        return repository.findAll();
    }
}