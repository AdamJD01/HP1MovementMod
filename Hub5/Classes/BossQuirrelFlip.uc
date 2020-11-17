class BossQuirrelFlip expands BaseBossQuirrel;

var   bool bQuirrelActive;

var() name          ClosestBlockPosNavPointTag;
var() name          BlocksTag;
var() int           NumBlocks;

//var float           fDistToBlockEndPos;
var float           fBlockStartPosY;
var NavigationPoint aBlockEndPos;

//var vector vBlockEndPosNormal;

const DEF_NumBlocks = 4;

const fShootDelay = 0.4;

var actor  aFlipBlock[4];
var actor  aTargetBlock;  //set to one of the 4

var int    NumRemainingShots;
var float  fTimeBetweenShots;
var int    RapidShotCounter;

var float  fSleepTime;

//var bool bShootingAtHarry; //if true, shooting at harry, otherwise shooting at a flipendo block
var vector vShootTarget;

var bool   bHarryVisible;
var bool   bLastHarryVisible;

//*************************************************************************************************************************
function PostBeginPlay()
{
	//local NavigationPoint  n;
	local int              i;
	local actor            a;
	local baseWand         weap;

	weap=spawn(class'baseWand');
	weap.BecomeItem();
	AddInventory(weap);
	weap.WeaponSet(self);
	weap.GiveAmmo(self);
	weap.FireOffset = vect(0,0,-50);

	//Look for our ClosestBlockPosNavPointTag actor
	if( ClosestBlockPosNavPointTag == '' )
		Log("************ ClosestBlockPosNavPointTag is not set in BossQuirrelFlip");

	ForEach AllActors(class'NavigationPoint', aBlockEndPos, ClosestBlockPosNavPointTag)
		break;

	if( aBlockEndPos == none )
		Log("************ BossQuirrelFlip: couldn't find NavigationPoint");

	//fDistToBlockEndPos = Abs( Location.y - aBlockEndPos.Location.y );

	// he's looking out the positive y direction
	//Log("************** vvvv : " $ n.Location - Location );

	if( NumBlocks != DEF_NumBlocks )
		Log("************  BossQuirrelFlip:  Inconsistent number of blocks...");
	if( BlocksTag == '' )
		Log("************  BossQuirrelFlip:  BlocksTag not set");
	if( ClosestBlockPosNavPointTag == '' )
		Log("************  BossQuirrelFlip:  ClosestBlockPosNavPointTag not set");

	// Find the blocks
	foreach allactors(class'actor', a, BlocksTag)
	{
		aFlipBlock[i] = a;
		i++;
	}

	if( i != 4 )
		Log("************  BossQuirrelFlip:  Didn't find all blocks");

	fBlockStartPosY = aFlipBlock[0].Location.y;

	
}

//*************************************************************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	if( bQuirrelActive )
		GotoState('stateIdle');
	else
		GotoState('statePause');

	bQuirrelActive = !bQuirrelActive;
}

//*************************************************************************************************************************
function tick(float dtime)
{
	local rotator   r;

	r = rotator( playerHarry.Location - Location );
	r.pitch = 0;
	DesiredRotation = r;
}

//*************************************************************************************************************************
function rotator AdjustAim(float projSpeed, vector projStart, int aimerror, bool bLeadTarget, bool bWarnTarget)
{
	local rotator r;

	if( vShootTarget == vect(0,0,0) )
		r = Rotation;
	else
		r = rotator( vShootTarget - Location );

	return r;
}

//*************************************************************************************************************************
/*auto*/ state statePause
{
  Begin:
	LoopAnim('breathe');
	//Wait for a bit
	Sleep( fSleepTime );//1.0 + 2.0*FRand() );

	bLastHarryVisible = bHarryVisible;

	//See if harry is visible
	bHarryVisible = LineOfSightTo( playerHarry );

playerHarry.ClientMessage("bHarryVisible = " $ bHarryVisible);

	if(   bHarryVisible
	   && abs( playerHarry.Location.y - Location.y ) > 175
	  )
	{
		//Shoot at harry
		GotoState('stateShootHarry');
	}
	else
	{
		//We want to sleep for a second or two, taking into account the sleep already done by fSleepTime
		fSleepTime = 4.0 + 2.0*FRand()  -  fSleepTime;
		fSleepTime = FMax( 0, fSleepTime );
		Sleep( fSleepTime );//1.0 + 2.0*FRand() );

		GotoState('stateShootBlock');
	}
}

//*************************************************************************************************************************
state stateShootHarry
{
	function BeginState()
	{
		//Everytime we shoot, increment this counter, if it's too high, pretend like harry wasn't visible last time time V checked.
		if( ++RapidShotCounter > 7 )
			bLastHarryVisible = false;

		if( !bLastHarryVisible )
		{
			fTimeBetweenShots = 3.25;
			RapidShotCounter = 0;
		}
	}

  Begin:
	baseWand(weapon).SelectSpell(Class'spellVoldemortStraight');

	//for( NumRemainingShots=3; NumRemainingShots > 0; NumRemainingShots-- )
	//{
		// fShootDelay is based on the animspeed multiplyer.
		PlayAnim('cast', 2.0, 0.1);
		
		//if fTimeBetweenShots is big enough, just wait the normal amount of time
		// This scheme doesn't take into account the anim running out
		if( fTimeBetweenShots >= fShootDelay )
		{
			Sleep( fShootDelay );
		}
		else //We need to jump ahead in the animation
		{
			AnimFrame = (1 - fTimeBetweenShots/fShootDelay) * 0.5; //when fTimeBetweenShots is 0, .5 makes AnimFrame be about the middle of the animation.
			Sleep( fTimeBetweenShots );
		}

		//If not the first shot, aim ahead.  hee hee

		vShootTarget = vect(0,0,0);// setting this to 0,0,0 will make AdjustAim do nothing.                  playerHarry.Location;

		ShootStraightSpellAtHarry( true );
		FinishAnim();

		//If harry is in the last few rows of the "grid", make the spell tracking
//		if( abs( playerHarry.Location.y - aBlockEndPos.Location.y ) < 96.0*2.5 )
			baseWand(weapon).LastCastedSpell.target = playerHarry;

	//}

	//Set sleep time, take out the .4 shootDelay
	fSleepTime  = FMax( 0, fTimeBetweenShots - fShootDelay );

	fTimeBetweenShots = FMax( 0, fTimeBetweenShots*0.5 );
	GotoState('statePause');
}

//*************************************************************************************************************************
state stateShootBlock
{
	//* * * * * * * * * * * * * * * * * * * * * * * * * * 
	function BeginState()
	{
		local int   i;
		local float fClosestDist;
		local float d;

		//Find which block to shoot
		fClosestDist = -50000;
		aTargetBlock = none;

		for( i = 0; i < NumBlocks; i++ )
		{
			//Wow, I screwed this up.  Better not muck with it now...
			d = /*abs(*/ aBlockEndPos.Location.y - aFlipBlock[i].Location.y /*)*/;

			if(   d > fClosestDist  //closest?
			   && d < 0             //Further away than our nav point.
			   && abs( aFlipBlock[i].Location.y - fBlockStartPosY ) > 40 //not at start position
			  )
			{
				aTargetBlock = aFlipBlock[i];
				fClosestDist = d;
			}
		}
	}

	//* * * * * * * * * * * * * * * * * * * * * * * * * * 
	function Tick(float dtime)
	{
		//Dont let Global.Tick run
	}

  Begin:
	//If we didn't find aTargetBlock in BeginState, go back to statePause
	if( aTargetBlock == none )
		GotoState('statePause');

	//All right, rotate to face our target
	TurnTo( aTargetBlock.Location );

	baseWand(weapon).SelectSpell(Class'spellFlip');

	PlayAnim('cast', 2.0, 0.1);
	Sleep( 0.4 );
	vShootTarget = aTargetBlock.Location;// + vect(0,0,50);
	//vShootTarget += vect(0,0,300);
	baseWand(weapon).CastSpell( none /*playerHarry*/ );
	FinishAnim();
	
	GotoState('statePause');
}

//*************************************************************************************************************************
auto state stateIdle
{
	function Tick(float dtime)
	{
		//Dont let the Global Tick run.
	}

  Begin:
	LoopAnim('breathe');
	Sleep(10);
	Goto 'Begin';
}

//*************************************************************************************************************************

defaultproperties
{
     GroundSpeed=90
     BaseEyeHeight=45
     EyeHeight=45
     Health=50
     MenuName="BossSquirrel"
     Physics=PHYS_Walking
     Mesh=SkeletalMesh'HPModels.skvoldemortMesh'
     DrawScale=1
     CollisionHeight=70
}
