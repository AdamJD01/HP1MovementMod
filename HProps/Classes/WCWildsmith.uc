//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCWildsmith extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardIgnatiaTex0  FILE=Textures\WizardCardIgnatiaTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Ignatia Wildsmith";
	ID = 62;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardIgnatiaTex0'
}
