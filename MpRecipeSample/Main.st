
PROGRAM _INIT

	recipes;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	readyToStart :=  NOT MpRecipeRegPar_0.Error AND NOT MpRecipeCsv_0.Error;
	
	IF NOT readyToStart THEN
		stateRecipe := stateRecipeError;
	END_IF
	
	CASE stateRecipe OF
		
		stateRecipeError:
			
			cmdLoad := FALSE;
			cmdSave := FALSE;
			
			IF readyToStart THEN
				stateRecipe := stateRecipeInit;
			END_IF
		
		stateRecipeInit:
			
			MpRecipeRegPar_0.MpLink := ADR(gRecipeCsv);
			MpRecipeRegPar_0.Enable := TRUE;
			MpRecipeRegPar_0.PVName := ADR('::recipes');
			
			MpRecipeCsv_0.MpLink := ADR(gRecipeCsv);
			MpRecipeCsv_0.Enable := TRUE;
			MpRecipeCsv_0.DeviceName := ADR('USER');
			MpRecipeCsv_0.FileName := ADR('recipe.csv');
						
			IF MpRecipeRegPar_0.Active AND MpRecipeCsv_0.Active THEN
				stateRecipe := stateRecipeLoad;
			END_IF
		
		stateRecipeWait:
			
			IF cmdLoad THEN
				stateRecipe := stateRecipeLoad;
			END_IF
			
			IF cmdSave THEN
				stateRecipe := stateRecipeSave;
			END_IF
		
		stateRecipeLoad:
			
			MpRecipeCsv_0.Load := TRUE;
			IF MpRecipeCsv_0.CommandDone THEN
				cmdLoad := FALSE;
				MpRecipeCsv_0.Load := FALSE;
				stateRecipe := stateRecipeWait;
			END_IF

		stateRecipeSave:
			
			MpRecipeCsv_0.Save := TRUE;
			IF MpRecipeCsv_0.CommandDone THEN
				cmdSave := FALSE;
				MpRecipeCsv_0.Save := FALSE;
				stateRecipe := stateRecipeWait;
			END_IF
		
	END_CASE

	MpRecipeRegPar_0();
	MpRecipeCsv_0();
	 
END_PROGRAM

PROGRAM _EXIT
	MpRecipeRegPar_0(Enable := FALSE);
	MpRecipeCsv_0(Enable := FALSE);
END_PROGRAM


