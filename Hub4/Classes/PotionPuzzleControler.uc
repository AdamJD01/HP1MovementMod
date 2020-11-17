// PotionPuzzleController - this class runs the potion puzzle reconfigs at the end of the game...
//	author:  Paul J. Furio

class PotionPuzzleControler extends HProps;

var basecam pcam;
var DummyPotionBottle DummyBottle0;
var DummyPotionBottle DummyBottle1;
var DummyPotionBottle DummyBottle2;
var DummyPotionBottle DummyBottle3;
var DummyPotionBottle DummyBottle4;
var MagicPotionBottle RealBottle;

var int nComplexityLevel;
var int nNumSwitches;
var float fLargestTick;
var bool bMeasureTick;
var bool bUsingHighPerformace;

var vector BottleLocation[6];

var DummyPotionBottle Position1Bottle;
var DummyPotionBottle Position2Bottle;
var DummyPotionBottle Position3Bottle;
var DummyPotionBottle Position4Bottle;
var DummyPotionBottle Position5Bottle;
var DummyPotionBottle Position6Bottle;

var int RandVal;
var int LastRandVal;
var int SoundRandVal;
var int LastSoundRandVal;

function findcam()
{
	foreach allActors(class'basecam', pcam)
	{
		break;
	}
}

function FinishGame()
{
	if(nComplexityLevel == 6)
		nComplexityLevel = 7;
}


function PreBeginPlay()
{
	Super.PreBeginPlay();

	nComplexityLevel = 1;
	
	// Find all the bottles
	foreach allActors(class'MagicPotionBottle', RealBottle)
	{
		break;
	}

	foreach allActors(class'DummyPotionBottle', DummyBottle0)
	{
		if(DummyBottle0.Name == 'DummyPotionBottle0')
			break;
	}

	foreach allActors(class'DummyPotionBottle', DummyBottle1)
	{
		if(DummyBottle1.Name == 'DummyPotionBottle1')
			break;
	}

	foreach allActors(class'DummyPotionBottle', DummyBottle2)
	{
		if(DummyBottle2.Name == 'DummyPotionBottle2')
			break;
	}

	foreach allActors(class'DummyPotionBottle', DummyBottle3)
	{
		if(DummyBottle3.Name == 'DummyPotionBottle3')
			break;
	}

	foreach allActors(class'DummyPotionBottle', DummyBottle4)
	{
		if(DummyBottle4.Name == 'DummyPotionBottle4')
			break;
	}

	BottleLocation[0] = DummyBottle4.Location;
	BottleLocation[1] = DummyBottle3.Location;
	BottleLocation[2] = DummyBottle2.Location;
	BottleLocation[3] = DummyBottle1.Location;
	BottleLocation[4] = RealBottle.Location;
	BottleLocation[5] = DummyBottle0.Location;

	Position1Bottle = DummyBottle4;
	Position2Bottle = DummyBottle3;
	Position3Bottle = DummyBottle2;
	Position4Bottle = DummyBottle1;
	Position5Bottle = RealBottle;
	Position6Bottle = DummyBottle0;

	fLargestTick = 0.0;
	bMeasureTick = false;
	bUsingHighPerformace = false;
}

// Start the Potion Shuffle
function Trigger( actor Other, pawn EventInstigator )
{
	local actor A;
	gotostate('BeginShuffle');

	//	if( Event != '' )
	//		foreach AllActors( class 'Actor', A, Event )
	//			A.Trigger( self, self );
}

function SetBottleCollisions(bool Value)
{
	DummyBottle4.SetCollision(Value,Value,Value);
	DummyBottle4.bProjTarget = Value;
	DummyBottle3.SetCollision(Value,Value,Value);
	DummyBottle3.bProjTarget = Value;
	DummyBottle2.SetCollision(Value,Value,Value);
	DummyBottle2.bProjTarget = Value;
	DummyBottle1.SetCollision(Value,Value,Value);
	DummyBottle1.bProjTarget = Value;
	DummyBottle0.SetCollision(Value,Value,Value);
	DummyBottle0.bProjTarget = Value;
	RealBottle.SetCollision(Value,Value,Value);
	RealBottle.bProjTarget = Value;
}

// Rotate some potion bottles
function Swap123(int nDirection)
{
	local DummyPotionBottle temp;

	if(nDirection == 0)	// Clockwise Turn
	{
		Position1Bottle.NewLocation = BottleLocation[1]; //Position2Bottle.Location;
		Position2Bottle.NewLocation = BottleLocation[2]; //Position3Bottle.Location;
		Position3Bottle.NewLocation = BottleLocation[0]; //Position1Bottle.Location;
	}
	else	// Counterclockwise turn
	{
		Position1Bottle.NewLocation = BottleLocation[2]; //Position3Bottle.Location;
		Position2Bottle.NewLocation = BottleLocation[0]; //Position1Bottle.Location;
		Position3Bottle.NewLocation = BottleLocation[1]; //Position2Bottle.Location;
	}

	Position1Bottle.gotostate('MoveToNewLocation');
	Position2Bottle.gotostate('MoveToNewLocation');
	Position3Bottle.gotostate('MoveToNewLocation');

	// Reorg Bottles
	if(nDirection == 0)	// Clockwise Turn
	{
		temp = Position2Bottle;
		Position2Bottle = Position1Bottle;
		Position1Bottle = Position3Bottle;
		Position3Bottle = temp;
	}
	else	// Counterclockwise turn
	{
		temp = Position1Bottle;

		Position1Bottle = Position2Bottle;
		Position2Bottle = Position3Bottle;
		Position3Bottle = temp;
	}
}

// Rotate some potion bottles
function Swap456(int nDirection)
{
	local DummyPotionBottle temp;


	if(nDirection == 0)	// Clockwise Turn
	{
		Position4Bottle.NewLocation = BottleLocation[4]; //Position5Bottle.Location;
		Position5Bottle.NewLocation = BottleLocation[5]; //Position6Bottle.Location;
		Position6Bottle.NewLocation = BottleLocation[3]; //Position4Bottle.Location;
	}
	else	// Counterclockwise turn
	{
		Position4Bottle.NewLocation = BottleLocation[5]; //Position6Bottle.Location;
		Position5Bottle.NewLocation = BottleLocation[3]; //Position4Bottle.Location;
		Position6Bottle.NewLocation = BottleLocation[4]; //Position5Bottle.Location;
	}

	Position4Bottle.gotostate('MoveToNewLocation');
	Position5Bottle.gotostate('MoveToNewLocation');
	Position6Bottle.gotostate('MoveToNewLocation');

	// Reorg Bottles
	if(nDirection == 0)	// Clockwise Turn
	{
		temp = Position6Bottle;
		Position6Bottle = Position5Bottle;
		Position5Bottle = Position4Bottle;
		Position4Bottle = temp;
	}
	else	// Counterclockwise turn
	{
		temp = Position6Bottle;

		Position6Bottle = Position4Bottle;
		Position4Bottle = Position5Bottle;
		Position5Bottle = temp;
	}
}

// Rotate some potion bottles
function Swap234(int nDirection)
{
	local DummyPotionBottle temp;

	if(nDirection == 0)	// Clockwise Turn
	{
		Position2Bottle.NewLocation = BottleLocation[2]; //Position3Bottle.Location;
		Position3Bottle.NewLocation = BottleLocation[3]; //Position4Bottle.Location;
		Position4Bottle.NewLocation = BottleLocation[1]; //Position2Bottle.Location;
	}
	else	// Counterclockwise turn
	{
		Position2Bottle.NewLocation = BottleLocation[3]; //Position4Bottle.Location;
		Position3Bottle.NewLocation = BottleLocation[1]; //Position2Bottle.Location;
		Position4Bottle.NewLocation = BottleLocation[2]; //Position3Bottle.Location;
	}

	Position2Bottle.gotostate('MoveToNewLocation');
	Position3Bottle.gotostate('MoveToNewLocation');
	Position4Bottle.gotostate('MoveToNewLocation');

	// Reorg Bottles
	if(nDirection == 0)	// Clockwise Turn
	{
		temp = Position3Bottle;
		Position3Bottle = Position2Bottle;
		Position2Bottle = Position4Bottle;
		Position4Bottle = temp;
	}
	else	// Counterclockwise turn
	{
		temp = Position2Bottle;

		Position2Bottle = Position3Bottle;
		Position3Bottle = Position4Bottle;
		Position4Bottle = temp;
	}
}

// Rotate some potion bottles
function Swap345(int nDirection)
{
	local DummyPotionBottle temp;

	if(nDirection == 0)	// Clockwise Turn
	{
		Position3Bottle.NewLocation = BottleLocation[3]; //Position4Bottle.Location;
		Position4Bottle.NewLocation = BottleLocation[4]; //Position5Bottle.Location;
		Position5Bottle.NewLocation = BottleLocation[2]; //Position3Bottle.Location;
	}
	else	// Counterclockwise turn
	{
		Position3Bottle.NewLocation = BottleLocation[4]; //Position5Bottle.Location;
		Position4Bottle.NewLocation = BottleLocation[2]; //Position3Bottle.Location;
		Position5Bottle.NewLocation = BottleLocation[3]; //Position4Bottle.Location;
	}

	Position3Bottle.gotostate('MoveToNewLocation');
	Position4Bottle.gotostate('MoveToNewLocation');
	Position5Bottle.gotostate('MoveToNewLocation');

	// Reorg Bottles
	if(nDirection == 0)	// Clockwise Turn
	{
		temp = Position4Bottle;
		Position4Bottle = Position3Bottle;
		Position3Bottle = Position5Bottle;
		Position5Bottle = temp;
	}
	else	// Counterclockwise turn
	{
		temp = Position3Bottle;

		Position3Bottle = Position4Bottle;
		Position4Bottle = Position5Bottle;
		Position5Bottle = temp;
	}
}

event Tick(float DeltaTime)
{
	if(bMeasureTick)
	{
		if(fLargestTick < DeltaTime)
			fLargestTick = DeltaTime;

		if(fLargestTick > 0.1)
			fLargestTick = 0.1;
	}
}


auto state idle
{
begin:

	playerharry.clientmessage("Potion Controller Entered Idle");
	Enable('Trigger');
loop:
	Sleep(1);
	goto('loop');
}


state BeginShuffle
{
	// switch based on Complexity Level...
begin:
	if(nComplexityLevel >= 6)	// This is a dumb cheat - use 6 to show that we did it 5 times
		gotostate('idle');

	// Lockdown the Camera somehow...

	switch(nComplexityLevel)
	{
	case 1:
		TriggerEvent( 'PotionShuffeStart1', self, None );
		break;
	case 2:
		TriggerEvent( 'PotionShuffeStart2', self, None );
		break;
	case 3:
		TriggerEvent( 'PotionShuffeStart3', self, None );
		break;
	case 4:
		TriggerEvent( 'PotionShuffeStart4', self, None );
		break;
	case 5:
		TriggerEvent( 'PotionShuffeStart5', self, None );
		break;
	}


	playerharry.clientmessage("Potion Controller Entered Shuffle");
	
	// A little Test Code to show that the Bottle was hit correctly...
	RealBottle.bEmitParticles = true;

	DummyBottle4.gotostate('Bottleflash');
	DummyBottle3.gotostate('Bottleflash');
	DummyBottle2.gotostate('Bottleflash');
	DummyBottle1.gotostate('Bottleflash');
	DummyBottle0.gotostate('Bottleflash');

	if(nComplexityLevel == 1)
		playSound(sound'HPSounds.Hub5_sfx.potion_start1');

	Sleep(5);

	RealBottle.bEmitParticles = false;

	// Start the switch

	nNumSwitches = nComplexityLevel * 8;	// Why use constants?  This isn't a real programming language...
	if(nComplexityLevel >= 4)
		nNumSwitches = nNumSwitches - nComplexityLevel;

	SetBottleCollisions(false);

	LastRandVal = -1;
	LastSoundRandVal = -1;

	bMeasureTick = true;


	// Only do this if we're not on a Low End Machine
	if((nComplexityLevel == 4)&&(fLargestTick < 0.1))
	{
		playerharry.clientmessage("Switched to High Performance Speeds: " @fLargestTick);
		DummyBottle0.groundspeed = 900.0;
		DummyBottle0.AccelRate = 900.0;
		DummyBottle1.groundspeed = 900.0;
		DummyBottle1.AccelRate = 900.0;
		DummyBottle2.groundspeed = 900.0;
		DummyBottle2.AccelRate = 900.0;
		DummyBottle3.groundspeed = 900.0;
		DummyBottle3.AccelRate = 900.0;
		DummyBottle4.groundspeed = 900.0;
		DummyBottle4.AccelRate = 900.0;
		RealBottle.groundspeed = 900.0;
		RealBottle.AccelRate = 900.0;
		bUsingHighPerformace = true;
	}
	else
	{
		playerharry.clientmessage("Kept Low Performance Speeds: " @fLargestTick);
	}	
	
	// do less switches in Slow Mode
	if( (nComplexityLevel >= 4) && (bUsingHighPerformace == false) )
	{
		if(nComplexityLevel == 4)
		{
			nNumSwitches = 18;
		}
		else
		{
			nNumSwitches = 15;
		}
	}

	while(nNumSwitches > 0)
	{
		playerharry.clientmessage("Numswitches: " @ nNumSwitches);

	//		** TEST CODE **
	//		playerharry.clientmessage("Swap123");
	//		Swap123(0);
	//		playerharry.clientmessage("Swap456");
	//		Swap456(0);


		while(RandVal == LastRandVal)
		{
			RandVal = rand(3);
		}

		LastRandVal=RandVal;

		switch(RandVal)
		{
		case 0:
			playerharry.clientmessage("Swap123");
			Swap123(rand(2));
			playerharry.clientmessage("Swap456");
			Swap456(rand(2));
			break;
		case 1:
			playerharry.clientmessage("Swap234");
			Swap234(rand(2));
			break;
		default:
			playerharry.clientmessage("Swap345");
			Swap345(rand(2));
			break;
		}

		while(LastSoundRandVal == SoundRandVal)
		{
			SoundRandVal = Rand(4);
		}

		LastSoundRandVal = SoundRandVal;

		// Play a Sound
		switch(SoundRandVal)
		{
		case 0:
			if(nComplexityLevel == 1)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle1');
			else if(nComplexityLevel == 2)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_fast1');
			else
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_faster1');
			break;
		case 1:
			if(nComplexityLevel == 1)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle2');
			else if(nComplexityLevel == 2)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_fast2');
			else
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_faster2');
			break;
		case 2:
			if(nComplexityLevel == 1)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle3');
			else if(nComplexityLevel == 2)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_fast3');
			else
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_faster3');
			break;
		default:
			if(nComplexityLevel == 1)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle4');
			else if(nComplexityLevel == 2)
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_fast4');
			else
				playSound(sound'HPSounds.Hub5_sfx.potion_shuffle_faster4');
			break;
		}

		nNumSwitches--;
		// Wait for switches to complete
		switch(nComplexityLevel)
		{
		case 1:
			Sleep(0.75);
			break;
		case 2:
			Sleep(0.60);
			break;
		case 3:
			Sleep(0.45);
			break;
		case 4:
			if(bUsingHighPerformace)
				Sleep(0.40);
			else
				Sleep(0.45);
			break;
		case 5:
			if(bUsingHighPerformace)
				Sleep(0.37);
			else
				Sleep(0.45);
			break;
		}
	}

	bMeasureTick = false;

	switch(nComplexityLevel)
	{
	case 1:
		TriggerEvent( 'PotionShuffeEnd1', self, None );
		break;
	case 2:
		TriggerEvent( 'PotionShuffeEnd2', self, None );
		break;
	case 3:
		TriggerEvent( 'PotionShuffeEnd3', self, None );
		break;
	case 4:
		TriggerEvent( 'PotionShuffeEnd4', self, None );
		break;
	case 5:
		TriggerEvent( 'PotionShuffeEnd5', self, None );
		break;
	}

	nComplexityLevel++;

	// Reset Collisions
	SetBottleCollisions(true);

	// Unlock the Camera but keep it in a High Mode...

	gotostate('idle');
}

//pcam.gotostate('cutstate');
//pcam.gotostate('standardstate');

// Confuse Bottles
// Change the Potions on the table to all be the same color



// Reorganize Bottles
// Swap their positions around



// Adjust speed and count
// Make the bottles move more quickly and up the number of swaps that
// they perform

defaultproperties
{
     bStatic=False
     Texture=Texture'Engine.S_Actor'
     bCollideActors=False
}
