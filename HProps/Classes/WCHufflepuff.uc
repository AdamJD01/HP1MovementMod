//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCHufflepuff extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardHelgaTex0  FILE=Textures\WizardCardHelgaTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Helga Hufflepuff";
	ID = 72;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardHelgaTex0'
}
