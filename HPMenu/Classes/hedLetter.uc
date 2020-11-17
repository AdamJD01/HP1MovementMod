class hedLetter expands basePopup;

#exec TEXTURE IMPORT NAME=hedLetter1 FILE=TEXTURES\hedletter1.BMP GROUP="Icons" FLAGS=2 MIPS=off
#exec TEXTURE IMPORT NAME=hedLetter2 FILE=TEXTURES\hedletter2.BMP GROUP="Icons" FLAGS=2 MIPS=off

var string text;
var string textName;

function DrawShadowedText(canvas canvas,string txt)
{
local color saveColor;
local int sx,sy;

	saveColor=Canvas.DrawColor;
	Canvas.DrawColor.r=0;
	Canvas.DrawColor.g=0;
	Canvas.DrawColor.b=0;

	sx=canvas.curx;
	sy=canvas.cury;

	Canvas.SetPos(sx+1,sy+1);
	Canvas.DrawText(txt,false);

	Canvas.DrawColor=saveColor;
	Canvas.SetPos(sx,sy);
	Canvas.DrawText(txt,false);

}

function Draw(Canvas canvas)
{
local float fx,fy,bx,by;
local float x,y,w,h;
local float tx,ty;	//text positions
local Texture tex;
local float sox,soy,scx,scy;	//temp storage for clip values.
local color save;
local sound dlgSound;

	fx=(Canvas.SizeX/640.0);
	fy=(Canvas.SizeY/480.0);
	fx=1.0;
	fy=1.0;

	tex=Texture'hedLetter1';
	w=tex.USize;
	h=tex.VSize;
	bx=(Canvas.SizeX/2)-(w);
	by=(Canvas.SizeY/2)-(h/2);
	Canvas.SetPos(bx*fx, by*fy);
	Canvas.DrawIcon(tex,1.0);

	tx=bx*fx;
	ty=by*fy;

	tex=Texture'hedLetter2';
	w=tex.USize;
	h=tex.VSize;
	x=(Canvas.SizeX/2);
	y=(Canvas.SizeY/2)-(h/2);
	Canvas.SetPos((bx+256)*fx, by*fy);
	Canvas.DrawIcon(tex,1.0);

	if(text=="")
	{

		text = Localize( "all", textName,"Pickup" );
/*
		playerHarry.theNarrator.FindDialog(textName,dlgSound,text);

		if(dlgSound!=None)
			PlaySound(dlgSound, SLOT_Talk,1.0, false, 1000.0, 0.9);*/
	}

	if(text!="")
		{
		sox=Canvas.OrgX;
		soy=Canvas.OrgY;
		scx=Canvas.ClipX;
		scy=Canvas.ClipY;	
		
		save=Canvas.DrawColor;

		Canvas.DrawColor.r=0;
		Canvas.DrawColor.g=0;
		Canvas.DrawColor.b=0;


		Canvas.OrgX=tx+80;
		Canvas.OrgY=ty+100;

		// Clip values are apparently widths & heights, 
		// relative to OrgX & Y, not absolute values.

		// Canvas.ClipX=Canvas.OrgX+200;
		// Canvas.ClipY=Canvas.OrgY+200;

		Canvas.ClipX = 354;
		Canvas.ClipY = 136;

		Canvas.SetPos(0, 0);
//		DrawShadowedText(canvas,text);
	Canvas.DrawText(text,false);

		Canvas.OrgX=sox;
		Canvas.OrgY=soy;

		Canvas.ClipX=scx;
		Canvas.ClipY=scy;

		Canvas.DrawColor=save;

		}

}

defaultproperties
{
     textName="XXX"
     LifeSpan=3
}
