//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCPotter extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardHarryTex0  FILE=Textures\WizardCardHarryTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Harry Potter";
	ID = 100;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardHarryTex0'
}
