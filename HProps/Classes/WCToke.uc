//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCToke extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardTillyTex0  FILE=Textures\WizardCardTillyTex0.bmp  GROUP=Skins


function PostBeginPlay()
{
	WizardName = "Tilly Toke";
	ID = 28;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardTillyTex0'
}
