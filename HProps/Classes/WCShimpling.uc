//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCShimpling extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardDerwentTex0  FILE=Textures\WizardCardDerwentTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Derwent Shimpling";
	ID = 8;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardDerwentTex0'
}
