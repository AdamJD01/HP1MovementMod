class BeansHudItem expands baseHudItem;

//#EXEC TEXTURE IMPORT NAME=beansIcon  FILE=..\HPMENU\TEXTURES\HUD\beansIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=beanCounter  FILE=TEXTURES\beanCounter.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

#EXEC TEXTURE IMPORT NAME=beans1  FILE=TEXTURES\beans1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=beans2  FILE=TEXTURES\beans2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=beans3  FILE=TEXTURES\beans3.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=beans4  FILE=TEXTURES\beans4.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

var	Texture		BeanTexture[4];

function int GetValue()
{
	return(playerHarry.numBeans);
}

function Paint(Canvas canvas)
{
	local float x;
	local int	iNumber;
	local int	iCount;

	if(yOffset<=-128)
		return;	//not visible

	super.paint(canvas);

	iNumber = GetValue();
	if (iNumber > 15)
	{
		iNumber = 15;
	}

	iNumber -= 3;
	iCount = 0;
	while(iNumber > 0)
	{
		x = Canvas.SizeX - xOffset;

		Canvas.SetPos(x,yOffset);

		Canvas.DrawIcon(BeanTexture[iCount],1);

		Canvas.SetPos(x+(BeanTexture[iCount].USize/2),yOffset+(BeanTexture[iCount].VSize/2));
		iCount ++;
		iNumber -= 3;
	}
}

defaultproperties
{
     BeanTexture(0)=Texture'HPMenu.Icons.beans1'
     BeanTexture(1)=Texture'HPMenu.Icons.beans2'
     BeanTexture(2)=Texture'HPMenu.Icons.beans3'
     BeanTexture(3)=Texture'HPMenu.Icons.beans4'
     Image=Texture'HPMenu.Icons.beancounter'
     xOffset=160
     yFinalOffset=4
}
