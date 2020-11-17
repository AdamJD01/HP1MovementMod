//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCStroulger extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardEdgarTex0  FILE=Textures\WizardCardEdgarTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Edgar Stroulger";
	ID = 47;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardEdgarTex0'
}
