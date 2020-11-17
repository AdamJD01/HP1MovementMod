//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCWright extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardBowmanTex0  FILE=Textures\WizardCardBowmanTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Bowman Wright";
	ID = 35;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardBowmanTex0'
}
