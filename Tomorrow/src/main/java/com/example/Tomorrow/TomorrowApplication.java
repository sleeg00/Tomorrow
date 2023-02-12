package com.example.Tomorrow;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

@SpringBootApplication
public class TomorrowApplication {
	public static void main(String[] args) {

		SpringApplication.run(TomorrowApplication.class, args);
	}
}
