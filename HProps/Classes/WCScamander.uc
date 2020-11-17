//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCScamander extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardNewtTex0  FILE=Textures\WizardCardNewtTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Newt Scamander";
	ID = 19;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardNewtTex0'
}
