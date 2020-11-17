// SneakFilch Class - used to detect "invisible Harry" walking around level...
// author - Paul J. Furio

class SneakFilch extends BaseSneakActor;

// "Public" Class Variables
var int soundDurration;
var float duration;
var sound dlgSound;
var string dlgText;
var bool bSoundResult;
var Actor LightPointer;


//*********************************************************************************************
// function PostBeginPlay - Set up all the pre game stuff
function PostBeginPlay()
{
	Super.PostBeginPlay();

	LightPointer = spawn(class'FilchLantern',self,,Location);
	LightPointer.SetOwner( Self );
	LightPointer.SetPhysics( PHYS_Trailer );
	LightPointer.AttachToOwner('lantern');

	// lantern - bone name for Light Ownership?
}

function RunToPredeterminedPointStartHack()
{
	// Make Filch say something on his way...
	switch(Rand(4))
	{
	case 0:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchD1",dlgSound,dlgText);
		break;
	case 1:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchD2",dlgSound,dlgText);
		break;
	case 2:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchD3",dlgSound,dlgText);
		break;
	case 3:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchD4",dlgSound,dlgText);
		break;
	}

	if(bSoundResult)
	{
		if(dlgSound!=None)
		{
			duration=GetSoundDuration(dlgSound);
			duration+=0.5;		//a little space between sounds.
			PlaySound(dlgSound,SLOT_Talk, 3.2, false, 2000.0, 1.0);
		}
	}	
}


// *** LookAround - If BaseSneakActor doesn't bump into Harry during RunLocation or Patrol, he'll stand around
//		"looking" to see what's up.  Bump is still active here...
state LookAround
{
	function bump(actor other)
	{	
		if(other==playerHarry)
		{
			disable('bump');
			// Give some kind of Patronizing "Caught" Remark.
			gotostate('Caught');
		}
	}

	event Tick(float DeltaTime)
	{
		// Figure out what Harry is doing...
		Super.Tick(DeltaTime);
		DormantCheckTick();

//		if(bMoveToBridgePoint)
//			gotostate('MovingToBridgePoint');
//		else
			FindHarryTick(DeltaTime);
	}

begin:

	groundspeed = OldGroundspeed;
	// Stop Moving

	if(CurrentRunToLocation == LastBaseStation.location)
	{
		DesiredRotation = LastBaseStation.rotation;
	}

	finishanim();

	// Make a squeaky Lantern Sound...
	playSound(sound'HPSounds.Hub4_sfx.lantern_creak');

	// Do a little lantern look...
	playanim('trans2holdlanternup');
	finishanim();
	playanim('holdlanternup');
	finishanim();
	playanim('transfromholdlantern');
	finishanim();

	// Now talk...
	playanim('trans2talk');
	finishanim();
	loopanim('talk');

	// AllEmotes

	switch(rand(11))
	{
	case 0:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchB3",dlgSound,dlgText);
		break;
	case 1:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchB4",dlgSound,dlgText);
		break;
	case 2:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchB5",dlgSound,dlgText);
		break;
	case 3:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchB6",dlgSound,dlgText);
		break;
	case 4:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchB7",dlgSound,dlgText);
		break;
	case 5:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchB8",dlgSound,dlgText);
		break;
	case 6:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchC1",dlgSound,dlgText);
		break;
	case 7:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchC2",dlgSound,dlgText);
		break;
	case 8:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchC3",dlgSound,dlgText);
		break;
	case 9:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchC4",dlgSound,dlgText);
		break;
	case 10:
		bSoundResult = playerHarry.theNarrator.FindDialog("142FilchC5",dlgSound,dlgText);
		break;
	}

	if(bSoundResult)
	{
		if(dlgSound!=None)
		{
			duration=GetSoundDuration(dlgSound);
			duration+=0.5;		//a little space between sounds.
			PlaySound(dlgSound,SLOT_Talk, 3.2, false, 2000.0, 1.0);
		}
	}

	Sleep(3.0);

	// Exit the talk cycle
	finishanim();
	playanim('tranfromtalk');	
	finishanim();

	if(bFollowPatrolPoints)
		gotostate('patrol');
	else
		RunToPredeterminedPoint(LastBaseStation);
}


function PostPawnAtPatrolPoint(PatrolPoint CurrentP, PatrolPoint NextP)
{
	Super.PostPawnAtPatrolPoint(CurrentP, NextP);
}


state Caught
{
	event Tick(float DeltaTime)
	{
		if(playerharry.HarryIsDead())
		{
			playerharry.KillHarry(true);
			gotostate('idle');
		}

		DormantCheckTick();
	}

Begin:
	loopanim('look');
	Acceleration = Vect(0,0,0);
	Velocity = Vect(0,0,0);

	if((playerharry.IsInState('CutIdleing'))||(playerharry.IsInState('CutMovingTo'))||
		(playerharry.IsInState('CutTurningTo'))||(playerharry.IsInState('CutAnimating')))
	{
		sleep(1.0);
		goto('begin');
	}

	disable('bump');	

	groundspeed = OldGroundspeed;

	// Stop Moving
	OldYaw = rotationrate.yaw;
	rotationrate.yaw = 0.0;
	moveto(location);
	rotationrate.yaw = OldYaw;

	// Take control of Harry from the player...
	playerharry.gotostate('harryfrozen');
	playerharry.turntoward(self);
	playerharry.rotationrate.yaw = 0.0;

	// Make Harry visible
	RevealHarry();

	turntoward(playerHarry);

	playanim('trans2talk');
	finishanim();
	loopanim('talk');

	// Play some "I caught You sound here..."
	switch(rand(2))
	{
	case 0:
		soundDurration=playerHarry.theNarrator.DeliverDialog("142FilchC6");
		break;
	case 1:
		soundDurration=playerHarry.theNarrator.DeliverDialog("142FilchB2");
		break;
	}

	playerharry.clientmessage("Filch says 'I got you, Potter!'");

	Sleep(1.0);

	// This sequence of animations "scolds" Harry...
	finishanim();
	playanim('transfromtalk');
	finishanim();
	playanim('trans2curse');
	finishanim();
	loopanim('curse');
	Sleep(2.0);
	finishanim();
	playanim('transfromcurse');
	finishanim();

killloop:
	playerHarry.KillHarry(true);
	loopanim('breathe');

	Sleep(1.0);

	goto('killloop');
	// Give some kind of Patronizing "Caught" Remark.
	// Kill Player, force reload...
}	

defaultproperties
{
     Mesh=SkeletalMesh'HPModels.skfilchlanternMesh'
     CollisionRadius=40
     CollisionHeight=51
}
