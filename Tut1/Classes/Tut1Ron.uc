class Tut1Ron extends baseChar;

var string introDialog[10];
var string bumpDialog[10];
var string randomDialog[10];
var int curDialogLine;
var bool bDidIntroDialog;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('breath', 1.0, 0.0);
}

event Bump(actor other)
{
	if(baseHarry(other)==None)
		return;
// Not used anymore....	gotostate('TalkingToHarry');	
}

state TalkingToHarry
{
begin:
	if(bDidIntroDialog)
		gotostate('');

	disable('bump');

	curDialogLine=0;
	playerHarry.forceHarryLook(self);
	while(bumpDialog[curDialogLine]!="")
		{
		playerHarry.ReceiveIconMessage(None,bumpDialog[curDialogLine],6.0);
		Sleep(6.0);
		curDialogLine++;
		}
	bDidIntroDialog=true;
	playerHarry.freeHarry();
	sleep(3.0);
	enable('bump');
	gotostate('');
}

defaultproperties
{
     bumpDialog(0)="Hey, Harry! Remember me - Ron Weasley?"
     bumpDialog(1)="I want you to meet Fred and George, they're my older twin brothers. They know all sorts of secrets about Hogwarts."
     bumpDialog(2)="Follow me!"
     GroundSpeed=230
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skronMesh'
     CollisionHeight=40
}
