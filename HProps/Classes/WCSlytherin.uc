//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCSlytherin extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardSalazarTex0  FILE=Textures\WizardCardSalazarTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Salazar Slytherin";
	ID = 48;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardSalazarTex0'
}
