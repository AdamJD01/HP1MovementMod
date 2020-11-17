class storybookbase extends inform;

var (storybook) class<hudStoryBook> storybookclass;
var(storybook) sound voiceover;

var hudStoryBook storyBook;

var baseHarry playerHarry;
var float talktime;


var (storybook) bool active;

function PreBeginPlay()
{
local int count;

	Super.PreBeginPlay();

	foreach AllActors(class'baseharry', playerHarry)
		{
		if( playerHarry.bIsPlayer&& playerHarry!=Self)
			{
				break;
			}
		}

}


function Trigger( actor Other, pawn EventInstigator )
{

	active=True;

}



function touch (actor other)
{

	if(other==playerharry&&active)
	{
		storybook=hpconsole(playerharry.player.console).ShowStoryBook(storybookclass);
		active=false;
		gotostate('displaytalk');
	}


}

function tick(float deltaTime)
{

	if(storybook!=None)
	{
		if(storybook.bShowStoryBook==False)
		{
			talkTime=0;
		}
	}
	talkTime=talkTime-deltaTime;


}

state displaytalk
{

	begin:
	playerharry.gotostate('harryfrozen');
	Playsound(voiceover, SLOT_talk, 1.0, true, 1000.0, 1.0);

	talkTime=GetsoundDuration(voiceover);
	while(talktime>0)
	{
		sleep(0.5);
	}
	playsound(sound'HPSounds.menu_sfx.s_menu_exit',SLOT_talk,0,false,0,0);
	
	hpconsole(playerharry.player.console).hideStoryBook();
	playerharry.gotostate('playerwalking');
	destroy();
	sleep(0.5);
}

defaultproperties
{
     Active=True
     bHidden=True
     DrawScale=2
     CollisionRadius=100
     CollisionHeight=100
     bCollideActors=True
}
