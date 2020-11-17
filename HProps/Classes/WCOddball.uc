//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCOddball extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardUlricTex0  FILE=Textures\WizardCardUlricTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Ulric the Oddball";
	ID = 18;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardUlricTex0'
}
