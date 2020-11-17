//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCGriffindor extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardGodricTex0  FILE=Textures\WizardCardGodricTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Godric Griffindor";
	ID = 41;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardGodricTex0'
}
