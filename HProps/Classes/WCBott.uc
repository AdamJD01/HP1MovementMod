//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCBott extends WizzardCardIcon;
#EXEC TEXTURE IMPORT NAME=WizardCardBertieTex0  FILE=Textures\WizardCardBertieTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Bertie Bott";
	ID = 69;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardBertieTex0'
}
