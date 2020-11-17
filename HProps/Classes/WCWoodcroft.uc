//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCWoodcroft extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardHengistTex0  FILE=Textures\WizardCardHengistTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Hengist of Woodcroft";
	ID = 96;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardHengistTex0'
}
