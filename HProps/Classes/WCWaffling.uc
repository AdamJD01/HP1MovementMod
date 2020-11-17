//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCWaffling extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardAdalbertTex0  FILE=Textures\WizardCardAdalbertTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Adalbert Waffling";
	ID = 24;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardAdalbertTex0'
}
