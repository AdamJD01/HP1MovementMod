//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCAgrippa extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardCornliusTex0  FILE=Textures\WizardCardCornliusTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Cornelius Agrippa";
	ID = 2;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardCornliusTex0'
}
