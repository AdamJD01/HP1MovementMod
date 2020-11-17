class PointHudItem expands baseHudItem;

//#EXEC TEXTURE IMPORT NAME=pointsIcon  FILE=..\HPMENU\TEXTURES\HUD\pointsIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=pointsIcon  FILE=TEXTURES\pointsIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

function int GetValue()
{
	return(playerHarry.getNumHousePointsHarry());
}

defaultproperties
{
     Image=Texture'HPMenu.Icons.pointsIcon'
     xOffset=160
     yFinalOffset=4
}
