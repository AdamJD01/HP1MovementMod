class SeedHudItem expands baseHudItem;

//#EXEC TEXTURE IMPORT NAME=FireSeedIcon  FILE=..\HPMENU\TEXTURES\HUD\FireSeedIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=FireSeedIcon  FILE=TEXTURES\FireSeedIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF


function int GetValue()
{
	return(playerHarry.iFireSeedCount);
}

function Paint(Canvas canvas)
{
	xOffset = canvas.SizeX * 3 / 4;
	Super.Paint(canvas);

}

defaultproperties
{
     Image=Texture'HPMenu.Icons.FireSeedIcon'
     xOffset=516
     yFinalOffset=4
}
