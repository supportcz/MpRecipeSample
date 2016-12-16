
TYPE
	Recipe : 	STRUCT 
		name : STRING[80];
		interlayerSheetBottom : BOOL;
		interlayerSheetTop : BOOL;
		conveyorP1speed : INT;
		conveyorP2speed : INT;
		timeAfterLastTrayInRow : TIME;
		timeDelayForTurn : TIME;
		wrapperSortiment : INT;
		nbOfLayers : INT;
	END_STRUCT;
	Recipes : 	STRUCT 
		actualRecipeIndex : INT;
		recipe : ARRAY[0..9]OF Recipe;
	END_STRUCT;
END_TYPE
