class hudStoryBook extends UWindowWindow;

var bool bShowStoryBook;
var bool bStoryBookVisible;
var int iStoryBookOffsetY;

//var hudSpellButton test1;
var() string storyText[20];

event Tick(float delta)
{
	if(!bShowStoryBook && iStoryBookOffsetY<=0)
		{
//Log("here");
		bStoryBookVisible=false;
		super.close(false);
		return;
		}

	if(bShowStoryBook)
		{
			//scroll in if needed 
		if(iStoryBookOffsetY<440)
			iStoryBookOffsetY+=((440-iStoryBookOffsetY)/10)+2;
		}
	else if(iStoryBookOffsetY>0)
		iStoryBookOffsetY-=((440-iStoryBookOffsetY)/10)+5;

	if(iStoryBookOffsetY<0)
		iStoryBookOffsetY=0;

	if(iStoryBookOffsetY>0)
		bStoryBookVisible=true;

}

function Close(bool flag)
{
	bShowStoryBook=false;	
}
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

function Paint(Canvas canvas,float x,float y)
{
local int width;
local int i;
local int ox,oy;


	if(bStoryBookVisible)
		{

		width=Texture'SpellBookTexture1'.USize+Texture'SpellBookTexture2'.USize;

		Canvas.SetPos((canvas.sizeX/2)-(width/2),canvas.sizeY-iStoryBookOffsetY);
		Canvas.DrawIcon(Texture'SpellBookTexture1',1);

		Canvas.SetPos(((canvas.sizeX/2)-(width/2))+256,canvas.sizeY-iStoryBookOffsetY);
		Canvas.DrawIcon(Texture'SpellBookTexture2',1);

		Canvas.SetPos((canvas.sizeX/2)-(width/2),(canvas.sizeY-iStoryBookOffsetY)+256);
		Canvas.DrawIcon(Texture'SpellBookTexture3',1);

		Canvas.SetPos(((canvas.sizeX/2)-(width/2))+256,(canvas.sizeY-iStoryBookOffsetY)+256);
		Canvas.DrawIcon(Texture'SpellBookTexture4',1);
		}

	ox=((canvas.sizeX/2)-(width/2))+85;
	oy=canvas.sizeY-iStoryBookOffsetY+20;
	Canvas.Font=Font'HPMenu.spellBookFont';

	i=0;
	while(storyText[i]!="")
		{
//		log(storyText[i]);
		Canvas.SetPos(ox+32,(oy+26)+i*15);
		DrawShadowedText(canvas,storyText[i]);
		i++;
		}


}

defaultproperties
{
}
