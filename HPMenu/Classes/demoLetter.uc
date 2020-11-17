class demoLetter expands basePopup;

#exec TEXTURE IMPORT NAME=welcomeLetter1 FILE=TEXTURES\welcomeLetter1.BMP GROUP="Icons" FLAGS=2 MIPS=off
#exec TEXTURE IMPORT NAME=welcomeLetter2 FILE=TEXTURES\welcomeLetter2.BMP GROUP="Icons" FLAGS=2 MIPS=off


function Draw(Canvas canvas)
{
local float fx,fy,bx,by;
local float x,y,w,h;
local Texture tex;

	fx=(Canvas.SizeX/640.0);
	fy=(Canvas.SizeY/480.0);
	fx=1.0;
	fy=1.0;

	tex=Texture'welcomeLetter1';
	w=tex.USize;
	h=tex.VSize;
	bx=(Canvas.SizeX/2)-(w);
	by=(Canvas.SizeY/2)-(h/2);
	Canvas.SetPos(bx*fx, by*fy);
	Canvas.DrawIcon(tex,1.0);

	tex=Texture'welcomeLetter2';
	w=tex.USize;
	h=tex.VSize;
	x=(Canvas.SizeX/2);
	y=(Canvas.SizeY/2)-(h/2);
	Canvas.SetPos((bx+256)*fx, by*fy);
	Canvas.DrawIcon(tex,1.0);

}

defaultproperties
{
     LifeSpan=2
}
