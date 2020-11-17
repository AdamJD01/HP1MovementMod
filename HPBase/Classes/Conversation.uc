class Conversation extends baseProps;

//#exec Texture Import File=..\engine\Textures\Path_B.pcx Name=Path_B Mips=Off Flags=2

#exec OBJ LOAD FILE=..\textures\hpedit.utx PACKAGE=HPBase.HPEdit

struct ScriptLine{
	var() string message;
	var() sound sound;
	var() float duration;
};


var () ScriptLine lines[10];
var () bool playOnce;
var () bool bTouchStarts;
var () bool bTriggerStarts;

var	int nCurLine;
var float fNextLineTime;
var bool bPlaying;
var bool bCanPlay;

event PostBeginPlay()
{
	super.postBeginPlay();
	bPlaying=false;
	fNextLineTime=0;
	nCurLine=0;
}

event Tick(float fDeltaTime)
{
	super.tick(fDeltaTime);
	if(!bPlaying)
		return;
	fNextLineTime-=fDeltaTime;
	if(fNextLineTime<=0.0)
		{
		playerHarry.ReceiveIconMessage(None,lines[nCurLine].message,lines[nCurLine].duration);
		if(lines[nCurLine].sound!=None)
			PlaySound(lines[nCurLine].sound, SLOT_Interact, 3.2, false, 2000.0, 1.0);
		fNextLineTime=lines[nCurLine].duration;
		nCurLine++;
		if(lines[nCurLine].message=="")
			{
			bPlaying=false;
			nCurLine=0;
			}
		}

}
event Touch(actor other)
{
	if(!bPlaying && bCanPlay && baseHarry(other)!=None)
		{
		if(playOnce)
			bCanPlay=false;
		bPlaying=true;
		fNextLineTime=0;
		nCurLine=0;
		}
}
event Trigger( Actor Other, Pawn EventInstigator )
{
	if(!bPlaying && bCanPlay)
		{
		if(playOnce)
			bCanPlay=false;
		bPlaying=true;
		fNextLineTime=0;
		nCurLine=0;
		}

}

defaultproperties
{
     Lines(0)=(duration=3)
     Lines(1)=(duration=3)
     Lines(2)=(duration=3)
     Lines(3)=(duration=3)
     Lines(4)=(duration=3)
     Lines(5)=(duration=3)
     Lines(6)=(duration=3)
     Lines(7)=(duration=3)
     Lines(8)=(duration=3)
     Lines(9)=(duration=3)
     playOnce=True
     bTouchStarts=True
     bTriggerStarts=True
     bCanPlay=True
     bStatic=False
     bHidden=True
     Texture=Texture'HPEdit.Icons.station'
}
