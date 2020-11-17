//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCOllerton extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardGiffordTex0  FILE=Textures\WizardCardGiffordTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Gifford Ollerton";
	ID = 57;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardGiffordTex0'
}
