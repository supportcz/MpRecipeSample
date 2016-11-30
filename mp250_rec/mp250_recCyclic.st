(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: mp250_rec
 * Created: October 2014
 ********************************************************************
 * Implementation of program mp250_rec
 ********************************************************************)

PROGRAM _INIT
	RegularCoffee.setTemp := 84;
END_PROGRAM	

PROGRAM _CYCLIC

	CASE sStep OF 
		enINIT:
			
		(*do nothing; sequence is started manually*)
		
		enACTIVATE:
			(*activate MpRecipe component*)
			MpRecipeXml_0.MpLink := 		ADR(gRecipeXml);
			MpRecipeXml_0.Enable := 		TRUE;
			
			IF MpRecipeXml_0.Active = TRUE THEN
				sStep := enREGISTER;
			END_IF

		enREGISTER:

			(*register process variables to recipe*)
			MpRecipeRegPar_0.MpLink := 		ADR(gRecipeXml);
			MpRecipeRegPar_0.Enable := 		TRUE;
			MpRecipeRegPar_0.ErrorReset := 	cmdErrorReset;
			MpRecipeRegPar_0.PVName := 		ADR('mp250_rec:RegularCoffee');

			(*check if parameter is active*)
			IF MpRecipeRegPar_0.Active = TRUE THEN
				sStep := enRECIPE;	
			END_IF
		
			(*check for errors*)
			IF MpRecipeRegPar_0.Error = TRUE THEN
				sStep := enERROR;
			END_IF
					
		enRECIPE:
			
			(*configure mapp recipe component*)
			MpRecipeXml_0.ErrorReset := 	cmdErrorReset;
			MpRecipeXml_0.DeviceName := 	ADR('RECIPE');
			MpRecipeXml_0.FileName := 		ADR('regular_coffee.xml');
			MpRecipeXml_0.Load := 			cmdLoadRecipe;
			MpRecipeXml_0.Save := 			cmdSaveRecipe;
			
			(*check for errors*)
			IF MpRecipeXml_0.Error = TRUE THEN
				sStep := enERROR;
			END_IF

			(*reset all commands when done*)
			IF MpRecipeXml_0.CommandDone = TRUE THEN
				cmdLoadRecipe := FALSE;
				cmdSaveRecipe := FALSE;
			END_IF
		
		enERROR:
		
		(*implement error handling here*)
		
	END_CASE
	
	(*call all mapp components*)
	MpRecipeRegPar_0();
	MpRecipeXml_0();
	
END_PROGRAM

PROGRAM _EXIT 

	(*disable all mapp components*)
	MpRecipeRegPar_0.Enable := FALSE;
	MpRecipeRegPar_0();
	MpRecipeXml_0.Enable := FALSE;
	MpRecipeXml_0();	

END_PROGRAM

