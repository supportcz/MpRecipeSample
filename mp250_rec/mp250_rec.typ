(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Programm: mp250_rec
 * Datei: mp250_rec.typ
 * Autor: Academy
 * Erstellt: 9. Oktober 2014
 ********************************************************************
 * Lokale Datentypen des Programms mp250_rec
 ********************************************************************)

TYPE
	enum_Sequence : 
		(
		enINIT,
		enACTIVATE,
		enREGISTER,
		enRECIPE,
		enERROR := 100
		);
	recipe_typ : 	STRUCT 
		price : REAL := 1.1;
		setTemp : REAL := 83.0;
		milk : REAL := 2.0;
		sugar : REAL := 1.0;
		coffee : REAL := 3.0;
		water : REAL := 24.0;
	END_STRUCT;
END_TYPE
