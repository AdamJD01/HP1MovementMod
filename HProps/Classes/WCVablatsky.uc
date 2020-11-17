//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class  WCVablatsky extends WizzardCardIcon;

#EXEC TEXTURE IMPORT NAME=WizardCardCassandraTex0  FILE=Textures\WizardCardCassandraTex0.bmp  GROUP=Skins

function PostBeginPlay()
{
	WizardName = "Cassandra Vablatsky";
	ID = 37;
	Super.PostBeginPlay();
}

defaultproperties
{
     Skin=Texture'HProps.Skins.WizardCardCassandraTex0'
}
