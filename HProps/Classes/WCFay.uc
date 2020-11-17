//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCFay extends WizzardCardIcon;
#EXEC TEXTURE IMPORT NAME=WizardCardMorganTex0  FILE=Textures\WizardCardMorganTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Morgan le Fay";
	ID = 17;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardMorganTex0'
}
