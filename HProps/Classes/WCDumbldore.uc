//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCDumbldore extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardDumbledoreTex0  FILE=Textures\WizardCardDumbledoreTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Albus Dumbledore";
	ID = 101;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardDumbledoreTex0'
}
