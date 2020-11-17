//=============================================================================
// HPHud
//=============================================================================
class PrivHud extends baseHUD;

#exec TEXTURE IMPORT NAME=LetterBackground1 FILE=TEXTURES\LetterBackground1.BMP GROUP="Icons" MIPS=ON
#exec TEXTURE IMPORT NAME=LetterBackground2 FILE=TEXTURES\LetterBackground2.BMP GROUP="Icons" MIPS=ON

#exec TEXTURE IMPORT NAME=LetterPiece1 FILE=TEXTURES\LetterPiece1.BMP GROUP="Icons" FLAGS=2 MIPS=ON
#exec TEXTURE IMPORT NAME=LetterPiece2 FILE=TEXTURES\LetterPiece2.BMP GROUP="Icons" FLAGS=2 MIPS=ON
#exec TEXTURE IMPORT NAME=LetterPiece3 FILE=TEXTURES\LetterPiece3.BMP GROUP="Icons" FLAGS=2 MIPS=ON
#exec TEXTURE IMPORT NAME=LetterPiece4 FILE=TEXTURES\LetterPiece4.BMP GROUP="Icons" FLAGS=2 MIPS=ON
#exec TEXTURE IMPORT NAME=LetterPiece5 FILE=TEXTURES\LetterPiece5.BMP GROUP="Icons" FLAGS=2 MIPS=ON
#exec TEXTURE IMPORT NAME=LetterPiece6 FILE=TEXTURES\LetterPiece6.BMP GROUP="Icons" FLAGS=2 MIPS=ON
#exec TEXTURE IMPORT NAME=LetterPiece7 FILE=TEXTURES\LetterPiece7.BMP GROUP="Icons" FLAGS=2 MIPS=ON

#exec TEXTURE IMPORT NAME=LetterIcon FILE=TEXTURES\LetterIcon.bmp GROUP="Icons" FLAGS=2 MIPS=ON


 
#exec Font Import File=Textures\Texture2.bmp Name=LargeRedFont

var int numLetterTicks;
var int numLetterPieces;


function LetterAddPiece()
{
	numLetterPieces++;
	//PlaySound(sound'HPSounds.letterSound', SLOT_Interact,0.5);
	LetterShow();
}

function LetterShow()
{
	numLetterTicks=160;	//show for 160 ticks. (~2.5sec) 
}
function LetterHide()
{
	numLetterTicks=0;	 
}
function LetterReset()
{
	numLetterPieces=0;
	numLetterTicks=0;	 
}
function DrawLetter(Canvas canvas)
{
local float w,h;
local float fx,fy;
local float x,y;
local float bx,by;
local Texture tex;

	if(numLetterTicks>0)
		{
		fx=(Canvas.SizeX/640.0);
		fy=(Canvas.SizeY/480.0);
		fx=1.0;
		fy=1.0;

		tex=Texture'LetterBackground1';
		w=tex.USize;
		h=tex.VSize;
		bx=(Canvas.SizeX/2)-(w);
		by=(Canvas.SizeY/2)-(h/2);
		Canvas.SetPos(bx*fx, by*fy);
		Canvas.DrawIcon(tex,1.0);

		tex=Texture'LetterBackground2';
		w=tex.USize;
		h=tex.VSize;
		x=(Canvas.SizeX/2);
		y=(Canvas.SizeY/2)-(h/2);
		Canvas.SetPos((bx+256)*fx, by*fy);
		Canvas.DrawIcon(tex,1.0);

		Canvas.style=2;
		if(numLetterPieces>0)
			{
			x=87;y=66;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece1',1.0);
			}
		if(numLetterPieces>1)
			{
			x=180;y=38;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece2',1.0);
			}
		if(numLetterPieces>2)
			{
			x=0;y=102;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece3',1.0);
			}
		if(numLetterPieces>3)
			{
			x=256;y=113;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece4',1.0);
			}
		if(numLetterPieces>4)
			{
			x=0;y=0;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece5',1.0);
			}
		if(numLetterPieces>5)
			{
			x=256;y=0;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece6',1.0);
			}
		if(numLetterPieces>6)
			{
			x=307;y=0;
			Canvas.SetPos((bx+x)*fx, (by+y)*fy);
			Canvas.DrawIcon(Texture'LetterPiece7',1.0);
			}


		Canvas.style=1;
		}
	Canvas.SetPos(Canvas.SizeX-68, Canvas.SizeY-36);
	Canvas.DrawIcon(Texture'LetterIcon',1.0);

	Canvas.SetPos(Canvas.SizeX-88, Canvas.SizeY-36);
	Canvas.DrawText(numLetterPieces, False);	

}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
//	ShowLetter();
}


simulated function PostRender( canvas Canvas )
{
	HUDSetup(canvas);

	if ( PlayerPawn(Owner) != None )
	{
		if ( PlayerPawn(Owner).PlayerReplicationInfo == None )
			return;

	}

	DrawLetter(Canvas);
	DrawIconMessages(Canvas);

}



simulated function Tick(float DeltaTime)
{
	if(numLetterTicks>0)
		numLetterTicks--;
/*
//Test the letter.
	if(numLetterTicks<=0)
		{
		LetterAddPiece();
		if(numLetterPieces>7)
			LetterReset();
		}
*/
}

defaultproperties
{
}
