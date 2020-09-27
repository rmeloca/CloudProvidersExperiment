package com.gabriel.db;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;

public class SingletonEntityManager {
		
		private static EntityManager em;
		
		private SingletonEntityManager() {
			
			em = Persistence.createEntityManagerFactory("RecordDataPU").createEntityManager();
		}
		
		public static synchronized EntityManager getInstance() {
			
			if (em != null)
				return em;
			else {
				new SingletonEntityManager();
				return em;
			}
		}
}

