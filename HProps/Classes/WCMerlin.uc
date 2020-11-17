//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCMerlin extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardMerlinTex0  FILE=Textures\WizardCardMerlinTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Merlin";
	ID = 1;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardMerlinTex0'
}
