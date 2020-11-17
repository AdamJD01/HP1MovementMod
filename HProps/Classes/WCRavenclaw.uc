//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCRavenclaw extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardRowenaTex0  FILE=Textures\WizardCardRowenaTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Rowena Ravenclaw";
	ID = 82;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardRowenaTex0'
}
