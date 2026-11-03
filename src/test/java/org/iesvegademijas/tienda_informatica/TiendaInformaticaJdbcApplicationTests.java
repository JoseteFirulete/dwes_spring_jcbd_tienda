package org.iesvegademijas.tienda_informatica;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.iesvegademijas.tienda_informatica.dao.ComercialDAO;
import org.iesvegademijas.tienda_informatica.dao.FabricanteDAO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class TiendaInformaticaJdbcApplicationTests {

	@Autowired
	private ComercialDAO comercialDAO;

	@Autowired
	private FabricanteDAO fabricanteDAO;

	@Test
	void contextLoads() {
	}

	@Test
	void comercialQueriesWorkWithTheExistingSchema() {
		assertNotNull(comercialDAO.getAll());
	}

	@Test
	void fabricanteQueriesUseTheTiendaSchema() {
		assertFalse(fabricanteDAO.getAll().isEmpty());
	}

}
