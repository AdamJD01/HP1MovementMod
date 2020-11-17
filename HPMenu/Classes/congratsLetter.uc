class congratsLetter expands basePopup;

#exec TEXTURE IMPORT NAME=congratsLetter1 FILE=TEXTURES\congratsLetter1.BMP GROUP="Icons" FLAGS=2 MIPS=off
#exec TEXTURE IMPORT NAME=congratsLetter2 FILE=TEXTURES\congratsLetter2.BMP GROUP="Icons" FLAGS=2 MIPS=off


function Draw(Canvas canvas)
{
local float fx,fy,bx,by;
local float x,y,w,h;
local Texture tex;

	fx=(Canvas.SizeX/640.0);
	fy=(Canvas.SizeY/480.0);
	fx=1.0;
	fy=1.0;

	tex=Texture'congratsLetter1';
	w=tex.USize;
	h=tex.VSize;
	bx=(Canvas.SizeX/2)-(w);
	by=(Canvas.SizeY/2)-(h/2);
	Canvas.SetPos(bx*fx, by*fy);
	Canvas.DrawIcon(tex,1.0);

	tex=Texture'congratsLetter2';
	w=tex.USize;
	h=tex.VSize;
	x=(Canvas.SizeX/2);
	y=(Canvas.SizeY/2)-(h/2);
	Canvas.SetPos((bx+256)*fx, by*fy);
	Canvas.DrawIcon(tex,1.0);

}

event destroyed()
{
	
	super.destroyed();

	playerHarry.gotostate('exittoMenu');
	

}

defaultproperties
{
     LifeSpan=2
}
