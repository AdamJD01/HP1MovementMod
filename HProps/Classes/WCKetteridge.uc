//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCKetteridge extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardElladoraTex0  FILE=Textures\WizardCardElladoraTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Elladora Ketteridge";
	ID = 49;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardElladoraTex0'
}
