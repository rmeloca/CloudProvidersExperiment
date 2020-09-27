package com.gabriel.db;

import javax.persistence.EntityManager;

public class ObservationDAO {
	
	private EntityManager em;
	
	public ObservationDAO() {
		em = SingletonEntityManager.getInstance();
	}
	
    public void create(Observation observation) {
        
    	try {
            em.getTransaction().begin();
            em.persist(observation);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                //em.close();
            }
        }
    }
}
