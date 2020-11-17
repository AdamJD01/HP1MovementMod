//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCHerpo extends WizzardCardIcon;
#EXEC TEXTURE IMPORT NAME=WizardCardHerpoTex0  FILE=Textures\WizardCardHerpoTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Herpo!";
	ID = 11;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardHerpoTex0'
}
