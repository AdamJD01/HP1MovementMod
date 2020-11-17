//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCMuldoon extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardBurdockTex0  FILE=Textures\WizardCardBurdockTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Burdock Muldoon";
	ID = 10;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardBurdockTex0'
}
