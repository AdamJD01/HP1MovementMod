class StarHudItem expands baseHudItem;

//#EXEC TEXTURE IMPORT NAME=StarIcon  FILE=..\HPMENU\TEXTURES\HUD\StarIcon.bmp GROUP=Icons FLAGS=2 MIPS=off
#EXEC TEXTURE IMPORT NAME=StarIcon  FILE=TEXTURES\StarIcon.bmp GROUP=Icons FLAGS=2 MIPS=off

function int GetValue()
{
	return(playerHarry.numStars);
}

function Paint(Canvas canvas)
{
	xOffset = canvas.SizeX / 2;
	Super.Paint(canvas);

}

defaultproperties
{
     Image=Texture'HPMenu.Icons.StarIcon'
     xOffset=384
     yFinalOffset=4
}
