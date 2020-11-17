class Tut1Dumbledore extends baseChar;

var string bumpDialog[10];
var string randomDialog[10];
var int curDialogLine;
var bool bDidIntroDialog;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('breath', 1.0, 0.0);
}

event xxxBump(actor other) //not used anymore
{
	if(baseHarry(other)==None)
		return;
	gotostate('TalkingToHarry');	
}
auto state DoNothing
{
}

state TalkingToHarry
{

begin:
	disable('bump');
	if(bDidIntroDialog)
		goto 'randomTalk';


	baseHud(playerHarry.myHud).bCutSceneMode=true;
	curDialogLine=0;
	playerHarry.CutDoIdle();

	while(bumpDialog[curDialogLine]!="")
		{
		playerHarry.ReceiveIconMessage(None,bumpDialog[curDialogLine],6.0);
		Sleep(6.0);
		curDialogLine++;
		}
	baseHud(playerHarry.myHud).bCutSceneMode=false;
	bDidIntroDialog=true;
	playerHarry.CutRelease();
	sleep(3.0);
	enable('bump');
	gotostate('');


randomTalk:
	playerHarry.ReceiveIconMessage(None,randomDialog[frand()*3],6.0);
	Sleep(6.0);
	enable('bump');
	gotostate('');
	
}

defaultproperties
{
     bumpDialog(0)="Welcome to Hogwarts, the school for Witches and Wizards. I am Albus Dumbledore, your Headmaster."
     bumpDialog(1)="Hogwarts is full of secrets, Harry, so search behind every door.  But keep in mind, not all secrets are rewarding."
     bumpDialog(2)="For instance, only this morning I took a wrong turn and stumbled upon a room full of Chocolate Frogs."
     bumpDialog(3)="But when I returned, the Chocolate Frogs had been replaced by a nasty horde of Fire Crabs."
     bumpDialog(4)="By the way, Harry, your Flipendo Knock-back jinx won't work in certain areas of the school. Precautions, don't you know."
     randomDialog(0)="Nitwit! Blubber! Oddment! Tweak! Four wonderful words don't you think?"
     randomDialog(1)="Ah, Hoggy Warty Hogwarts - a wonderful place to explore."
     randomDialog(2)="Off you trot, Harry.  You'll never know where these corridors lead, unless you explore them."
     bDidIntroDialog=True
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdumbledoreMesh'
     CollisionHeight=40
}
