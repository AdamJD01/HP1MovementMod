class baseHudItem expands actor;

var texture image;
var float xOffset,yOffset;
var float yFinalOffset;
var float duration;	//time before it will auto hide.
var int value;
var baseHarry PlayerHarry;


event tick(float fDeltaTime)
{
	if(duration>0)
		{
		duration-=fDeltaTime;
		if(yOffset<yFinalOffset)
			{
			yOffset+=(yFinalOffset-yOffset)/5;
			}
		}
	else
		{
		if(yOffset>-128)
			{
			yOffset+=(-128-yOffset)/5;
			}

		}
//	playerHarry.clientMessage(yOffset);
}

function Paint(Canvas canvas)
{
	local float x;
	local color	OldColor;

	if(yOffset<=-128)
		return;	//not visible

	x=Canvas.SizeX-xOffset;

	Canvas.SetPos(x,yOffset);
	Canvas.DrawIcon(image,1);

	if (GetValue() < 10)
	{
		Canvas.SetPos(x+(image.USize/2) - 5,yOffset+(image.VSize/2) + 5);
	}
	else
	{
		Canvas.SetPos(x+(image.USize/2) - 10,yOffset+(image.VSize/2) + 5);
	}
	OldColor = Canvas.DrawColor;
	Canvas.DrawColor.r = 0;
	Canvas.DrawColor.g = 0;
	Canvas.DrawColor.b = 0;
	Canvas.DrawText(GetValue(), False);
	Canvas.DrawColor = OldColor;
}

function int GetValue()
{
	return(0);
}
function Show()
{
	duration=5.0;
}

defaultproperties
{
     xOffset=128
     yOffset=-128
     yFinalOffset=5
     bHidden=True
}
