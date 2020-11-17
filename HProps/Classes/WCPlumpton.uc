//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCPlumpton extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardRodericTex0  FILE=Textures\WizardCardRodericTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Roderic Plumpton";
	ID = 83;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardRodericTex0'
}
