class baseQHudGame expands actor;

#EXEC TEXTURE IMPORT NAME=HandBar			FILE=TEXTURES\HandBar.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=BarTip			FILE=TEXTURES\BarTip.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ClosedHand		FILE=TEXTURES\ClosedHand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ClosedHandKey		FILE=TEXTURES\ClosedHandKey.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=ClosedHandSnitch	FILE=TEXTURES\ClosedHandSnitch.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=HalfOpenHand		FILE=TEXTURES\HalfOpenHand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=OpenHand			FILE=TEXTURES\OpenHand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=Snitch			FILE=TEXTURES\Snitch.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#EXEC TEXTURE IMPORT NAME=Key				FILE=TEXTURES\Key.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

/*var texture image;
var float xOffset,yOffset;
var float yFinalOffset;
var float duration;	//time before it will auto hide.
var int value;
var baseHarry PlayerHarry;
*/

var int			iTargetPos;
var int			iCatchPos;
var int			iAimPoint;
var() float		fDuration;
var texture		TargetImage;
var texture		SuccessImage;
var baseHarry	Player;
var bool		bMore;

var float		fGrabTime;
var bool		bGrabbed;

event tick(float fDeltaTime)
{
	local int	iDist;
	// Play game

	fDuration -= fDeltaTime;
	fGrabTime -= fDeltaTime;

/*	if (fDuration < 0)
	{
		// end game
		baseHUD(Player.myHUD).PlayHUDGame(false);
		Destroy();
	}
*/
	// Change the snitch(keys) location

	if (iAimPoint == iTargetPos)
	{
		if (rand(4) == 0)
		{
			iAimPoint = rand(iCatchPos);
//			iAimPoint = 0;
			bMore = true;
		}
		else
		{
			if (bMore)
			{
				iAimPoint = rand(256 - iTargetPos) + iTargetPos;
			}
			else
			{
				iAimPoint = rand(iTargetPos);
			}

			bMore = !bMore;
		}
	}
	else
	{
		iDist = fdeltatime * 256;

		if (iDist > abs(iTargetPos - iAimPoint))
		{
			iDist = abs(iTargetPos - iAimPoint);
		}

		if (iTargetPos > iAimPoint)
		{
			iTargetPos -= iDist;
		}
		else
		{
			iTargetPos += iDist;
		}
	}
	iTargetPos = fclamp(iTargetPos, 0, 255);
}

function SetQuidditchMatch()
{
	// Set up the snitch image
	TargetImage = texture'Snitch';
	SuccessImage = texture'closedhandsnitch';
	fGrabTime = 0;
	baseHUD(player.myHUD).ShowPopup(class'basewarning');
	basewarning(baseHUD(player.myHUD).curPopup).DisplayText = Localize( "all", "catch_snitch_text_02","Pickup" );
}

function SetFlyingKeys()
{
	// Set up the key image
	TargetImage = texture'Key';
	SuccessImage = texture'closedhandkey';
	fGrabTime = 0;
	baseHUD(player.myHUD).ShowPopup(class'basewarning');
	basewarning(baseHUD(player.myHUD).curPopup).DisplayText = Localize( "all", "flying_key_text_02","Pickup" );
}

function bool Grab()
{
	if (iTargetPos < iCatchPos)
	{
		bGrabbed = true;
	}
	else
	{
		bGrabbed = false;
		fGrabTime = 0.5;
	}

	return bGrabbed;
}

function Paint(Canvas canvas)
{
	local	Texture	BarImage;
	local	Texture HandImage;
	local	Texture	BarTipImage;

	local	Texture	Background;

	local float xpos, ypos;

	BarImage = Texture'HandBar';
	BarTipImage = Texture'BarTip';

	if (bGrabbed)
	{
		HandImage = SuccessImage;
	}
	else if (fGrabTime > 0)
	{
		HandImage = Texture'ClosedHand';
	}
	else if (iTargetPos < iCatchPos)
	{
		HandImage = Texture'OpenHand';
	}
	else
	{
		HandImage = Texture'HalfOpenHand';
	}

	xpos = (Canvas.SizeX / 2) - (BarImage.USize / 2);
	ypos = Canvas.Sizey - 64;

	Canvas.SetPos(xpos,ypos);
	Canvas.DrawIcon(BarImage, 1);

	Canvas.SetPos(xpos + BarImage.USize, ypos);
	Canvas.DrawIcon(BarTipImage, 1);

	Canvas.SetPos(xpos - 92, ypos - 11);
	Canvas.DrawIcon(HandImage, 1);

	if (!bGrabbed)
	{
		Canvas.SetPos(xpos + iTargetPos - 64, ypos);
		Canvas.DrawIcon(TargetImage, 1);
	}
}

function Destroyed()
{
	baseHUD(player.myHUD).DestroyPopup();
}

defaultproperties
{
     iTargetPos=128
     iCatchPos=48
     iAimPoint=128
     fDuration=30
}
