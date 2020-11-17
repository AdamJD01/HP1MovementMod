//=============================================================================
// Harry  -- hero character 
//=============================================================================
class Harry extends baseHarry;
//---------------------------------------------------------------------------------------------------------------------------------------------------
//Edited by- AdamJD (edited code will have AdamJD by it)
//---------------------------------------------------------------------------------------------------------------------------------------------------
//Description- Tried to make Harrys movement similar to HP2 and improved climbing. All edited code is UScript (no C++)
//---------------------------------------------------------------------------------------------------------------------------------------------------
//Edited Dates- Between: 30/09/2019-20/12/2019 (DD/MM/YYYY)
//---------------------------------------------------------------------------------------------------------------------------------------------------

//#exec MESH  ORIGIN MESH=skHarryMesh X=0 Y=0 Z=28 YAW=0 PITCH=0 ROLL=0
//#exec MESH WEAPONATTACH MESH=skHarryMesh BONE="RightHand"
//#exec MESH WEAPONPOSITION MESH=skHarryMesh YAW=0 PITCH=0 ROLL=10 X=0.0 Y=0.0 Z=0.0


var(Messages)	localized string spreenote[10];
var(Sounds)		Sound Deaths[6];
var int			FaceSkin;
var int			FixedSkin;
var int			TeamSkin1;
var int			TeamSkin2;
var int			MultiLevel;
var string		DefaultSkinName;
var string		DefaultPackage;
var float		LastKillTime;

var(Sounds) sound 	drown;
var(Sounds) sound	breathagain;
var(Sounds) sound	HitSound3;
var(Sounds) sound	HitSound4;
var(Sounds) sound	Die2;
var(Sounds) sound	Die3;
var(Sounds) sound	Die4;
var(Sounds) sound	GaspSound;
var(Sounds) sound	UWHit1;
var(Sounds) sound	UWHit2;
var(Sounds) sound	LandGrunt;
var(Sounds) sound speech[20];
var(Display) const class<Decal> ShadowClass;

var bool bLastJumpAlt;
/*
var  globalconfig bool bInstantRocket;
var	 globalconfig bool bAutoTaunt; // player automatically generates taunts when fragging someone
var	 globalconfig bool bNoAutoTaunts; // don't receive auto-taunts
var  globalconfig bool bNoVoiceTaunts; // don't receive any taunts
var  globalconfig bool bNoMatureLanguage;
var  globalconfig bool bNoVoiceMessages; // don't receive any voice messages
var bool bNeedActivate;
*/

var bool b3DSound;

var int WeaponUpdate;

// HUD status 
var texture StatusDoll, StatusBelt;

// allowed voices
var string VoicePackMetaClass;

var NavigationPoint StartSpot; //where player started the match

var Weapon ClientPending;
var Weapon OldClientWeapon;

var globalconfig int AnnouncerVolume;
//var class<CriticalEventPlus> TimeMessageClass;

//var class<Actor> BossRef;

var byte LastbLook;

var bool bFallingMount;
var bool bIsPickingUpWizardCard;

var bool bBossHasAThumbOnYourHead;

// AE:
var bool bPlayedFallSound;

var bool bPlayedFirstColumnWobbleSpeech;

var float fTimeToStop;

var bool	bOldStrafingState;
var float   fOldGroundSpeed;

// in chess mode, Harry can only move at certain times, and only to certain locations

var	bool	bChessMoving;
var	bool	bHarrysMove;
var string eaid[128];

var bool	bEnded;

var	vector	ChessTargetLocation;

const  NUM_HURT_SOUNDS = 15;
var sound   HurtSound[15];

var float    fTimeInAir;  //try and measure how long you've been in PHYS_Falling
var EPhysics eLastPhysState;
var float    fFallingZ;   //try and save your z when you start falling.

// Mount vars.
var vector	MountDelta;
var actor	MountBase;

//my playercasting var -AdamJD 
var bool bPlayerCasting; //is the player casting?

//for BroomHarry and the chess board -AdamJD
const	MIN_MOUSE_DELTA_X	= -20000.0f;	
const	MAX_MOUSE_DELTA_X	=  20000.0f;
const	MIN_MOUSE_DELTA_Y	= -10000.0f;
const	MAX_MOUSE_DELTA_Y	=  10000.0f;

//**********************************************************************************************
//moved to near the top... where it should be -AdamJD
event PreBeginPlay()
{
	Super.PreBeginPlay();
		
	foreach AllActors(class'baseNarrator', theNarrator)
		break;
	if(theNarrator==None)
	{
		theNarrator=spawn(class 'Narrator');
		Log("Narrator spawned:" $theNarrator);
	}		

}

//moved to near the top... where it should be -AdamJD
function PostBeginPlay()
{
    local Pawn p;
	local weapon weap;
	Super.PostBeginPlay();

	b3DSound = bool(ConsoleCommand("get ini:Engine.Engine.AudioDevice Use3dHardware"));

	bShowMenu=false;
	log("weapon is" $weapon);
	if(inventory==none)
	{
		weap=spawn(class'baseWand');
		weap.BecomeItem();
		AddInventory(weap);
		weap.WeaponSet(self);
		weap.GiveAmmo(self);
		baseWand(weap).bUseMana=false;
		log(self$ " spawning weap " $weap);
	}
	else
	{
		log("not spawning weap");
	}

	iFireSeedCount = 0;

	HUDType=class'HPMenu.HPHud';
	
	ForEach AllActors( class'baseCam', cam )
		break;
	if( cam == none )
		cam = spawn( class'baseCam' );

	viewClass(class'baseCam', true);
	//viewClass(class 'BaseCam', true);
  	// @PAB added new camera target
  	//makeCamTarget();	//not needed -AdamJD

	// Harry gets a shadow, bigger than normal.
	Shadow = Spawn(ShadowClass,self);
	log( self$ " ShadowClass=" $ShadowClass$ " shadow=" $Shadow$ " tex=" $Shadow.Texture );

// @PAB temp give a spell to Harry
	//baseWand(weap).addSpell(Class'spellDud'); //not needed -AdamJD
//	baseWand(weap).addSpell(Class'spellflip');
//	baseWand(weap).addSpell(Class'spellALOho');
//	baseWand(weap).SelectSpell(Class'spellFlip');

	HarryAnimChannel = cHarryAnimChannel( CreateAnimChannel(class'cHarryAnimChannel', AT_Replace, 'harry spine1') );
	HarryAnimChannel.SetOwner( self );
	
	basewand(weapon).ChooseSpell( SPELL_None ); //set wand to no spell when first loaded -AdamJD
}

//Play a sound client side (so only client will hear it)
simulated function ClientPlaySound(sound ASound, optional bool bInterrupt, optional bool bVolumeControl )
{	
	local actor SoundPlayer;
	local int Volume;

	if ( b3DSound )
	{
		if ( bVolumeControl && (AnnouncerVolume == 0) )
			Volume = 0;
		else
			Volume = 1;
	}
	else if ( bVolumeControl )
		Volume = AnnouncerVolume;
	else
		Volume = 4;

	LastPlaySound = Level.TimeSeconds;	// so voice messages won't overlap
	if ( ViewTarget != None )
		SoundPlayer = ViewTarget;
	else
		SoundPlayer = self;

	if ( Volume == 0 )
		return;
	SoundPlayer.PlaySound(ASound, SLOT_None, 16.0, bInterrupt);
	if ( Volume == 1 )
		return;
	SoundPlayer.PlaySound(ASound, SLOT_Interface, 16.0, bInterrupt);
	if ( Volume == 2 )
		return;
	SoundPlayer.PlaySound(ASound, SLOT_Misc, 16.0, bInterrupt);
	if ( Volume == 3 )
		return;
	SoundPlayer.PlaySound(ASound, SLOT_Talk, 16.0, bInterrupt);
}

function DebugState()
{
//	BaseHUD(MyHUD).DebugString2 = string(GetStateName());
//	ClientMessage(string(GetStateName()));
//	log("Harry state is " $string(GetStateName()));

}

function TurnDebugModeOn()
{	
	hpconsole(player.console).bDebugMode = true;
}

function PreSetMovement()
{
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = true;
	bCanFly = false;
	bCanOpenDoors = true;
	bCanDoSpecial = true;
}

//*******************************************************************************
function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
							Vector momentum, name damageType)
{
	local Sound snd;

	//Log("********* "$self$" ib:"$instigatedBy$" damateType:"$damageType);

	//Check and see if harry has life potions left
	if( !HarryIsDead() )
	{
		if( DamageType == 'ZonePain' || DamageType == 'pit' )
		{
			//AE:
			// if( FRand() < 0.5 )
				// theNarrator.FindEmote("EmotiveHarry13", snd);
			// else
				// theNarrator.FindEmote("EmotiveHarry14", snd);

			PlaySound( snd );

			gotostate ('hit_InstantPitDeath');
			bHidden = true;
		}
		else
		{
			//playsound(sound'HPSounds.dlg_har.har_002');
			PlaySound( HurtSound[ Rand(NUM_HURT_SOUNDS) ] );

/*			if(rectarget!=none)
			{
				rectarget.destroy();
			}

			if (Physics != phys_falling)
			{*/
				gotostate ('hit');
//			}
		}
	}

	super.takedamage(Damage, instigatedBy,hitlocation, // Will change state to 'stateDead' if enough damage
							momentum, damageType);
}

//*******************************************************************************
exec function Summon( string ClassName )
{
	local class<actor> NewClass;
	if( instr(ClassName,".")==-1 )
		ClassName = "HPDecorations." $ ClassName;
	Super.Summon( ClassName );
}

simulated function PlayFootStep()
{
	local sound step;
	local float decision;

	local Texture HitTexture;
	local int Flags;

	local sound Footstep1;
	local sound Footstep2;
	local sound Footstep3;

	if ( FootRegion.Zone.bWaterZone )
	{
		PlaySound(WaterStep, SLOT_Interact, 1, false, 1000.0, 1.0);
		return;
	}

	HitTexture = TraceTexture(Location + (vect(0,0,-128)), Location, Flags );

	Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_wood1';
	Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_wood2';
	Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_wood3';

	if(HitTexture!=None)	//cmp 10-17 log spam fix.
		{
		switch( HitTexture.FootstepSound )
			{
			case FOOTSTEP_Rug:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_rug1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_rug2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_rug3';
				break;

			case FOOTSTEP_Wood:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_wood1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_wood2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_wood3';
				break;

			case FOOTSTEP_Stone:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_stone1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_stone2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_stone3';
				break;

			case FOOTSTEP_cave:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_cave1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_cave2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_cave3';
				break;

			case FOOTSTEP_cloud:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_cloud1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_cloud2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_cloud3';
				break;

			case FOOTSTEP_wet:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_wet1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_wet2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_wet3';
				break;

			case FOOTSTEP_grass:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_grass1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_grass2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_grass3';  //bad sound
				break;

			case FOOTSTEP_metal:
				Footstep1 = Sound'HPSounds.FootSteps.HAR_foot_metal1';
				Footstep2 = Sound'HPSounds.FootSteps.HAR_foot_metal2';
				Footstep3 = Sound'HPSounds.FootSteps.HAR_foot_metal3';
				break;
			}
		}
	decision = FRand();
	if ( decision < 0.34 )
		step = Footstep1;
	else if (decision < 0.67 )
		step = Footstep2;
	else
		step = Footstep3;

	PlaySound(step, SLOT_None,1, false, 1000.0, 0.9);
}

//****************************************************************************************************
function VoldColumnGotWobbled()
{
	local sound snd;
	local string str;

	if( !bPlayedFirstColumnWobbleSpeech )
	{
		bPlayedFirstColumnWobbleSpeech = true;

		theNarrator.FindDialog("harry_159", snd, str);
		PlaySound(snd, Slot_none);
	}
}

//****************************************************************************************************
function PlayHit(float Damage, vector HitLocation, name damageType, vector Momentum)
{
/*	local float rnd;
	local Bubble1 bub;
	local bool bServerGuessWeapon;
	local class<DamageType> DamageClass;
	local vector BloodOffset, Mo;
	local int iDam;

	if ( (Damage <= 0) && (ReducedDamageType != 'All') )
		return;

	//DamageClass = class(damageType);
	if ( ReducedDamageType != 'All' ) //spawn some blood
	{
		if (damageType == 'Drowned')
		{
			bub = spawn(class 'Bubble1',,, Location 
				+ 0.7 * CollisionRadius * vector(ViewRotation) + 0.3 * EyeHeight * vect(0,0,1));
			if (bub != None)
				bub.DrawScale = FRand()*0.06+0.04; 
		}
		else if ( (damageType != 'Burned') && (damageType != 'Corroded') 
					&& (damageType != 'Fell') )
		{
			BloodOffset = 0.2 * CollisionRadius * Normal(HitLocation - Location);
			BloodOffset.Z = BloodOffset.Z * 0.5;
			if ( (DamageType == 'shot') || (DamageType == 'decapitated') || (DamageType == 'shredded') )
			{
				Mo = Momentum;
				if ( Mo.Z > 0 )
					Mo.Z *= 0.5;
				spawn(class 'UT_BloodHit',self,,hitLocation + BloodOffset, rotator(Mo));
			}
			else
				spawn(class 'UT_BloodBurst',self,,hitLocation + BloodOffset);
		}
	}	

	rnd = FClamp(Damage, 20, 60);
	if ( damageType == 'Burned' )
		ClientFlash( -0.009375 * rnd, rnd * vect(16.41, 11.719, 4.6875));
	else if ( damageType == 'Corroded' )
		ClientFlash( -0.01171875 * rnd, rnd * vect(9.375, 14.0625, 4.6875));
	else if ( damageType == 'Drowned' )
		ClientFlash(-0.390, vect(312.5,468.75,468.75));
	else 
		ClientFlash( -0.019 * rnd, rnd * vect(26.5, 4.5, 4.5));

	ShakeView(0.15 + 0.005 * Damage, Damage * 30, 0.3 * Damage); 
	PlayTakeHitSound(Damage, damageType, 1);
	bServerGuessWeapon = ( ((Weapon != None) && Weapon.bPointing) || (GetAnimGroup(AnimSequence) == 'Dodge') );
	iDam = Clamp(Damage,0,200);
	ClientPlayTakeHit(hitLocation - Location, iDam, bServerGuessWeapon ); 
	if ( !bServerGuessWeapon 
		&& ((Level.NetMode == NM_DedicatedServer) || (Level.NetMode == NM_ListenServer)) )
	{
		Enable('AnimEnd');
		BaseEyeHeight = Default.BaseEyeHeight;
		bAnimTransition = true;
		PlayTakeHit(0.1, hitLocation, Damage);
	}*/
}


function DoJump( optional float F )
{
	local baseProps  a;
	local float      TmpJumpZ;
	local float 	 s; //AdamJD local float

	if( bKeepStationary )
		return;

//	log("PLOG jumping");
	if( Physics == PHYS_Walking )
	{
		if ( !bUpdating )
			PlayOwnedSound(JumpSound, SLOT_Talk, 1.5, true, 1200, 1.0 );
		if ( (Level.Game != None) && (Level.Game.Difficulty > 0) )
			MakeNoise(0.1 * Level.Game.Difficulty);

		MountDelta = Location;
		if( VSize2D(Velocity) > 0 )
			PlayAnim('jump2');
		else
			PlayAnim('jump');
/*
		switch( Rand(3) )
		{
			case 0:    PlaySound( sound'HPSounds.HAR_emotes.jump1' );     break;
			case 1:    PlaySound( sound'HPSounds.HAR_emotes.jump2' );     break;
			case 2:    PlaySound( sound'HPSounds.HAR_emotes.jump3' );     break;
		}
*/
		TmpJumpZ = JumpZ;

		//not needed -AdamJD
		/*
		//See if you're standing on a double jump actor
		//foreach TouchingActors( class'baseProps', a )
		foreach allactors( class'baseProps', a )
		{
			//clientmessage("prop");

			if(   a.bSuperJump
			   //&& (normal(Location - a.Location) dot vect(0,0,1)) > 0.7
			   && VSize2d(a.Location - Location) < a.CollisionRadius+CollisionRadius
			   && abs(a.Location.z+CollisionHeight - Location.z) < 100 // How do you get the top of a collision cylinder?
			  )
			{
				clientmessage("super jump");
				TmpJumpZ *= a.JumpMultiplier;
				break;
			}
		}
		*/
		
		Velocity.Z += TmpJumpZ;

		if ( (Base != Level) && (Base != None) )
			Velocity += Base.Velocity;
		
		//let player cast if jumping -AdamJD
		if (bPlayerCasting)
		{
			HarryAnimType = AT_Replace;
			HarryAnimChannel.GotoStateCasting();
			PlayAnim('jump');
		}

		SetPhysics(PHYS_Falling);
	}
}

//-----------------------------------------------------------------------------
// Sound functions

//*****************************************************************************************
//This isn't done in Global.Landed() cause you dont want the sound when harry grabs a ledge
function PlayLandedSound()
{
	local sound   step;
	local float   decision;
	local Texture HitTexture;
	local int     Flags;
	local float   vol;

	if ( FootRegion.Zone.bWaterZone )
	{
		PlaySound(WaterStep, SLOT_Interact, 1, false, 1000.0, 1.0);
		return;
	}

	HitTexture = TraceTexture(Location + (vect(0,0,-128)), Location, Flags );

	step = Sound'HPSounds.FootSteps.HAR_Landing_stone';

	switch( HitTexture.FootstepSound )
	{
		case FOOTSTEP_Wood:
		//	step = Sound'HPSounds.FootSteps.HAR_Landing_wood';
			break;

		case FOOTSTEP_cloud:
		case FOOTSTEP_grass:
		case FOOTSTEP_Rug:
			step = Sound'HPSounds.FootSteps.HAR_Landing_rug';
			break;

		case FOOTSTEP_Stone:
		case FOOTSTEP_cave:
			step = Sound'HPSounds.FootSteps.HAR_Landing_stone';
			break;

		case FOOTSTEP_wet:
			step = Sound'HPSounds.FootSteps.HAR_Landing_wet';
			break;

		case FOOTSTEP_metal:
			step = Sound'HPSounds.FootSteps.HAR_Landing_metal';
			break;
	}

	if( fTimeInAir < 1.0 )
		vol = 0.3 * fTimeInAir;
	else
		vol = 0.3 + (fTimeInAir - 1.0) * 0.7/0.5;

	//if you fell, rather than jumped, make the sound louder
	if( Location.z < fFallingZ - 40 )
		vol *= 2;

//	PlaySound(step, SLOT_Interact, vol, false, 1000.0, 0.9);

	switch( Rand(5) )
	{
		case 0:    step = sound'HPSounds.Har_emotes.landing1';    break;
		case 1:    step = sound'HPSounds.Har_emotes.landing2';    break;
		case 2:    step = sound'HPSounds.Har_emotes.landing3';    break;
		case 3:    step = sound'HPSounds.Har_emotes.landing4';    break;
		case 4:    step = sound'HPSounds.Har_emotes.landing5';    break;
	}

	PlaySound(step, SLOT_Misc, vol, false, 1000.0);
}

//*****************************************************************************************
function Gasp()
{

	if ( PainTime < 2 )
		PlaySound(GaspSound, SLOT_Talk, 2.0);
	else
		PlaySound(BreathAgain, SLOT_Talk, 2.0);
}

//-----------------------------------------------------------------------------
// Animation functions

function PlayTurning()
{
	PlayAnim('Turn', [Type] HarryAnimType); 
}

function TweenToRunning(float tweentime)
{
	local vector X,Y,Z, Dir;

	BaseEyeHeight = Default.BaseEyeHeight;
	
	//not needed -AdamJD
	// if (bIsWalking)
	// {
		// TweenToWalking(0.1);
		// return;
	// }
	
	GetAxes(Rotation, X,Y,Z);
	Dir = Normal(Acceleration);
	//old retail code -AdamJD
	/*
	if ( (Dir Dot X < 0.75) && (Dir != vect(0,0,0)) )
	{
		// strafing or backing up
		if ( Dir Dot X < -0.75 )
		{
			PlayAnim('runback', 0.9, tweentime, HarryAnimType );
			bMovingBackwards=true;
			//Velocity.X /= 2;
		}
		else if ( Dir Dot Y > 0 )
		{
			PlayAnim('StrafeRight', 0.9, tweentime, HarryAnimType );
			//Velocity.Y /=2;
		}
		else
			PlayAnim('StrafeLeft', 0.9, tweentime, HarryAnimType );
	}
	else 
	{
		PlayAnim('run', 0.9, tweentime, HarryAnimType );
		bMovingBackwards=false;
	}
	*/
	
	//code copied from PlayRunning -AdamJD
	if ( (Dir Dot X < 0.75) && (Dir != vect(0,0,0)) )
	{
		// strafing or backing up
		if ( Dir Dot X < -0.75 )
		{
			LoopAnim('runback', [Type] HarryAnimType);
			bMovingBackwards=true; 
			//Velocity.X /= 2;
		}
		else if ( Dir Dot Y > 0 )
		{
			LoopAnim('StrafeRight', [Type] HarryAnimType);
			//clientmessage("strafe right");
			//Velocity.Y /= 2;
		}
		else
		{
			LoopAnim('StrafeLeft', [Type] HarryAnimType); 
		}
	}
	
	//player has pressed the forward input so play the run anim -AdamJD
	else if ( Dir Dot X >= 0.75 && (Dir != vect(0,0,0)) )
	{
		LoopAnim('run', [Type] HarryAnimType);
		bMovingBackwards=false; 
	}
	
	//stops Harry if player is pressing left and right inputs at the same time -AdamJD
	else
	{
		LoopAnim('breath', [Type] HarryAnimType);
		Dir = vect(0,0,0);
	}
}

function PlayRunning()
{
	TweenToRunning( 0 );
	//not needed -AdamJD
	/*
	local vector X,Y,Z, Dir;

	BaseEyeHeight = Default.BaseEyeHeight;

	// determine facing direction
	clearMessages=true;
	GetAxes(Rotation, X,Y,Z);
	Dir = Normal(Acceleration);
	if ( (Dir Dot X < 0.75) && (Dir != vect(0,0,0)) )
	{
		// strafing or backing up
		if ( Dir Dot X < -0.75 )
		{
			LoopAnim('runback', [Type] HarryAnimType);
			bMovingBackwards=true;
			//Velocity.X /= 2;
		}
		else if ( Dir Dot Y > 0 )
		{
			LoopAnim('StrafeRight', [Type] HarryAnimType);
			//clientmessage("strafe right");
			//Velocity.Y /= 2;
		}
		else
		{
			LoopAnim('StrafeLeft', [Type] HarryAnimType);
		}
	}
	else 
	{
		LoopAnim('run', [Type] HarryAnimType);
		bMovingBackwards=false;
	}*/
}


function PlayinAir()
{
	// AE:
	if( Physics == PHYS_Falling )
	{
		if( !bPlayedFallSound  &&  fTimeInAir > 1.0 )
		{
			bPlayedFallSound = true;
			PlaySound( sound'HPSounds.HAR_emotes.falldeep2' );

		}
	}
	
	loopAnim('fall');
}


function PlayDuck()
{
	BaseEyeHeight = 0;
	TweenAnim('SneakF', 0.25);
}

function PlayCrawling()
{
	//log("Play duck");
	BaseEyeHeight = 0;
	LoopAnim('SneakF');
}

//stop Harry walking with his arms down after playing the cast anim (he walked like a penguin...) -AdamJD
function PlayFinishCastAnim()
{
	LoopAnim('breath', 0.10, 0.5, HarryAnimType);
	gotoState('PlayerWalking');
}

//stop Harry walking with his arms up after throwing a wizard cracker -AdamJD
function PlayFinishThrowCrackerAnim()
{
	LoopAnim('breath', 0.10, 0.5, HarryAnimType);
	gotoState('PlayerWalking');
}

function PlayWaiting()
{
	local name newAnim;

	if ( Mesh == None )
		return;

		//keep idle from happening as soon as a level loads
	WaitingCount++;
	if(!bPlayerCasting) //don't do this if casting -AdamJD
	{
		if(WaitingCount<2)	//do breath first three times you get here.
			{
			LoopAnim('breath', 0.4 + 0.4 * FRand(), 0.25, , HarryAnimType);
			return;
			}

		if ( FRand() < 0.3)
		{
			LoopAnim('breath', 0.4 + 0.4 * FRand(), 0.25, , HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('Look', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('Scratch', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('Scratch', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('lookwand', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('adjustglasses', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('look2', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('look3', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else if(FRand() < 0.03 )
		{
			WaitingCount=0;
			PlayAnim('look4', 0.5 + 0.5 * FRand(), 0.3, HarryAnimType);
		}
		else
		{
			LoopAnim('breath', 0.4 + 0.4 * FRand(), 0.25, , HarryAnimType);
		}
	}
}


function TweenToWaiting(float tweentime)
{
	//TweenAnim('breath', tweentime, [Type] HarryAnimType);
	LoopAnim( 'breath', , tweentime, , HarryAnimType );
}

function Cast()
{
	local actor BestTarget;
	local actor HitActor;
	local rotator defaultAngle, checkAngle;
	local pawn hitPawn;
	local vector objectDir;
	local int bestYaw;
	local int tempYaw, defaultYaw;
	local float	BestDist, TempDist;

	defaultAngle = Rotation;
	defaultAngle.pitch = 0;
	defaultYaw = defaultAngle.yaw;
	defaultYaw = defaultYaw & 0xffff;
	
	//old code by me -AdamJD
	/*
	bOldStrafingState = (bStrafe != 0);

	MovementMode(true);
	
	if (bPressedJump) 
	{
		DoJump();
		bPressedJump = false;
	}
	*/

	if (defaultyaw > 0x7fff)
	{
		defaultyaw -= 0x10000;
	}

	bestTarget = none;

	//Also, if you're fighting a boss, make sure your target is the boss
	if( BossTarget != none )
	{
		target = BossTarget;
	}
/*	else if (rectarget.victim == none)
	{
		// find a possible target

		bestTarget = ExtendTarget();
			
		if(bestTarget != none)
		{
			rectarget.victim = bestTarget;
		}
	}
*/
	if(rectarget.victim==none)
	{
		// @PAB if no victim, aim for target
		if(underAttack)
		{
			basewand(weapon).ChooseSpell(attacker.eVulnerableToSpell);
			basewand(weapon).forcespell(rectarget);
		}
		else
		{
			basewand(weapon).castspell(rectarget);
		}
	}
	else
	{
		if(underAttack)
		{
			basewand(weapon).ChooseSpell(attacker.eVulnerableToSpell);
			basewand(weapon).forcespell(rectarget.victim);
		}
		else
		{
			basewand(weapon).castspell(rectarget.victim);
		}
	}
	
	//Weapon.AltFire(1.0);
	rectarget.destroy(); 
	//turn off wand casting -AdamJD
	basewand(weapon).bCasting=false;
}


// The player wants to fire.
exec function Fire( optional float F )
{	
	bJustFired = true;
}

// The player wants to alternate-fire.
exec function AltFire( optional float F )
{
	local vector v;
	local rotator r;

	// If Harry is frozen, disable firing
	if (IsInState('HarryFrozen') || baseHud(myhud).bCutSceneMode == true) //|| Physics == PHYS_Falling //can now cast when falling -AdamJD
	{
		//stop casting if in cutscene/Harry is frozen (can't get cursor to turn off, pissing me off) -AdamJD
		//Update: Putting this in PlayerWalking instead fixed it... -AdamJD
		/*
		if(bPlayerCasting == true)
		{
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			return;
		}
		*/
		return;
	}

	if( BossTarget != none && bCanCast == false)
	{
		if( bThrow == false  &&  projectile(CarryingActor) != none  &&  IsInState('PlayerWalking') )
		{
			ClientMessage("Throw!");
			//Start throw animation, state PlayerWalking will monitor it from there
			HarryAnimChannel.GotoStateThrow();
			bThrow = true;

			//The animation channel will then call ThrowCarryingActor() when the time is right
		}
	}
	else
	{
		if(   Weapon != None
		   //&& bJustAltFired == false
		   && CarryingActor == none   //you're not carrying an actor in your hand
		   && !bPlayerCasting //player is not already casting -AdamJD
		  )
		{
			//ClientMessage("Harry::AltFire");
			//Weapon.bPointing = true;
			//	PlaySound(sound'spell1', SLOT_Interact, 2.2, false, 1000.0, 1.0);
			//	weapon.altfire(1);
			
			//turn on player casting -AdamJD
			//bJustAltFired = true;
			bPlayerCasting = true;
			// Weapon.bPointing = true;
			//basewand(weapon).bCasting=true;
			StartCasting();
			//gotostate('playeraiming'); 
		}
		
		//turn off player casting -AdamJD
		else 
		{
			//Weapon.bPointing = false;
			bPlayerCasting = false;
			StopCasting();
		}
	}
}

//AdamJD
function StartCasting()
{
	//leaving this empty goes to the StartCasting function in state PlayerWalking instead 
}

//AdamJD
function StopCasting()
{
	//leaving this empty goes to the StopCasting function in state PlayerWalking instead 
}

//stop spell/wand noises -AdamJD
function StopSoundFX()
{
	StopSound(sound'HPSounds.Magic_sfx.spell_build_nl2', SLOT_Misc);
	StopSound(sound'HPSounds.Magic_sfx.spell_loop_nl', SLOT_Interact);
}

event Mount( vector Delta )
{
	// Use Destination to store dest, as moveTo won't be called here.
	Destination = Location+Delta;
	MountBase = Base;
			
	if( Physics == PHYS_Falling )
	{
		bFallingMount = true;
		gotoState('FallingMount');
		
		//stop Harry casting when climbing -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}
	}
	else
	{
		bFallingMount = false;
		gotoState('Mounting');
		
		//stop Harry casting when climbing -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}
	}
}

state FallingMount
{
	ignores AltFire;

	event PlayerTick( float DeltaTime )
	{
		global.PlayerTick( DeltaTime );
		
		DesiredRotation.Pitch = 0; //copied from the HP2 proto -AdamJD
		
		// Adjust destination by player and base movement.
		Destination.X += Location.X - OldLocation.X;
		Destination.Y += Location.Y - OldLocation.Y;
		if( Mover(MountBase) != none )
			Destination += MountBase.Location - MountBase.OldLocation;

		// Wait till we fall to catch point.
		if( Location.Z <= Destination.Z-82 )
		{
			// Move to exact height.
			Move( vec(0, 0, Destination.Z-82 - Location.Z) );
			gotoState('Mounting');
		}
	}

	function Mount(vector Delta)
	{
		// Update Dest.
		Destination = Location+Delta;
		MountBase = Base;
	}

	function Landed(vector HitNormal)
	{
		PlaySound(Sound'HPSounds.HAR_emotes.landing5', SLOT_Interact,1, false, 1000.0, 0.9);
		//gotoState('Mounting'); //not needed -AdamJD
	}
	
	//not needed -AdamJD
	/*
	function BeginState()
	{
		DebugState();
		// Fall until we get to an exact mount height.
		// Start tweening to proper animation.
		playAnim('climb96end', [Rate] 0, [TweenTime] 0.5, [RootBone] 'move');
	}
	*/

begin:
	// Start turning here as well.
	//TurnTo( vec(Destination.X, Destination.Y, Location.Z) ); //not needed -AdamJD
	
	//copied from the HP2 proto -AdamJD
	DesiredRotation.Yaw = rotator( vec(Destination.X, Destination.Y, Location.Z) - Location ).yaw;
	DesiredRotation.Pitch = 0; 
	gotoState ('Mounting'); 
}

state Mounting
{
	ignores Mount, AltFire;
	
	//copied from the HP2 proto -AdamJD
	event PlayerTick( float DeltaTime )
	{
		global.PlayerTick( DeltaTime );
		DesiredRotation.Pitch = 0;
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)
	{
		// Ignore acceleration.
		global.ProcessMove( DeltaTime, vect(0,0,0), DodgeMove, DeltaRot );
	}

	function BeginState()
	{
		DebugState();

		// Disable normal physics while performing mounting move.
		Velocity = vect(0,0,0);
		Acceleration = vect(0,0,0);
		SetPhysics(PHYS_Projectile);
		SetBase(MountBase);
	}

begin:
	// Finish turning.
	TurnTo( vec(Destination.X, Destination.Y, Location.Z) );
	
	DesiredRotation.Pitch = 0; //copied from the HP2 proto -AdamJD

	MountDelta = Destination - Location;

	// Subtract anim movement from delta.
	MountDelta -= vect(30,0,0) >> Rotation;
	
	//original mounting code -AdamJD
	/*
	if( bFallingMount )
	{
		MountDelta.Z -= 82;
		playAnim('climb96end', [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.pull_up3', , 0.5 );
	}
	else if( MountDelta.Z < 48 )
	{
		MountDelta.Z -= 32;
		playAnim('climb32', [Rate] 1.0, [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.EmotiveHarry5_b_pullup6', , 0.5 );
	}
	else if( MountDelta.Z < 80 )
	{
		MountDelta.Z -= 64;
		playAnim('climb64', [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.EmotiveHarry5_a_pullup5', , 0.5 );
	}
	else
	{
		MountDelta.Z -= 96;
		playAnim('climb96start', [RootBone] 'move');
	}
	*/
	
	if( MountDelta.Z < 48 ) //for climbing from a short distance -AdamJD
	{
		MountDelta.Z -= 32;
		playAnim('climb32', [Rate] 1.0, [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.EmotiveHarry5_b_pullup6', , 0.5 );
	}
	
	else if ((MountDelta.Z >=48) && (MountDelta.Z < 80)) //for climbing from a medium distance -AdamJD
	{
		MountDelta.Z -= 64;
		playAnim('climb64', [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.EmotiveHarry5_a_pullup5', , 0.5 );
	}
	
	else if ((MountDelta.Z >=80) && (MountDelta.Z < 98)) //for climbing from a long distance -AdamJD
	{
		MountDelta.Z -= 82;
		playAnim('climb96end', [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.pull_up3', , 0.5 );
	}
	
	else //for climbing from a really long distance -AdamJD
	{
		MountDelta.Z -= 96;
		playAnim('climb96start', [RootBone] 'move');
	}

	gotoState('MountFinish');
}

state MountFinish
{
	ignores Mount, AltFire;

	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)
	{
		// Ignore acceleration.
		global.ProcessMove( DeltaTime, vect(0,0,0), DodgeMove, DeltaRot );
	}

	event PlayerTick( float DeltaTime )
	{
		local vector v;

		// Add additional movement for actual mount offset.
		v = MountDelta * DeltaTime*AnimRate;
		Move(v);
		ViewRotation = Rotation;
		global.PlayerTick( DeltaTime );
	}

	function BeginState()
	{
		DebugState();
		// Shrink collision for more lenient movement in world.
		SetCollisionSize( CollisionRadius*0.5, CollisionHeight*0.5, CollisionHeight*0.5 );
		PrePivot.Z -= CollisionHeight;
	}

	function EndState()
	{
		PrePivot.Z += CollisionHeight;
		SetCollisionSize( CollisionRadius*2, CollisionHeight*2, 0 );
	}

begin:

	if( AnimSequence == 'climb96start' )
	{
		// Split delta movement in 2.
		MountDelta *= 0.5;
		finishAnim();
		playAnim('climb96end', [RootBone] 'move');
		PlaySound( sound'HPSounds.HAR_emotes.EmotiveHarry5_a_pullup5', , 0.5 );
	}
	finishAnim();

	// Restore physics.
	SetPhysics(PHYS_Walking);

	// Play idle anim in case nothing's happening.
	playAnim('breath');
	gotostate('PlayerWalking');
	
	//stop casting a spell after climbing something -AdamJD
	if(bPlayerCasting == true)
	{
		bPlayerCasting = false;
		StopCasting();
		baseWand(weapon).bPointing = false;
		basewand(weapon).bCasting=false;
		baseWand(Weapon).WandEffect.bHidden = true;
		rectarget.destroy();
		StopSoundFX();
	}
}

//********************************************************************************************
state hit
{
	ignores DoJump, bump;

	function Landed(vector HitNormal)
	{
		clientMessage("landed: jump dist = " $VSize(Location-MountDelta) $ "   tia="$fTimeInAir);

		Global.Landed(HitNormal);

		PlayLandedSound();

//		playanim('land1');
		velocity *= 0;

//		log("PLOG Hitstate landed");

	}

	function EndState()
	{
//		log("PLOG end Hitstate");
	}

	function animEnd()
	{
		bPressedJump = false;
		gotostate('PlayerWalking');
	}

	begin:
		disable('AnimEnd');
		DebugState();
		bThrow = false;

//		log("PLOG Hitstate");

		if(rectarget!=none)
			rectarget.destroy();

		//If we're carrying an item, toss it forward a bit.  At this point, we'll assume it's
		// a firecracker
		if( CarryingActor != none )
			DropCarryingActor();

		if( AnimSequence != 'knockback2' )
			playanim('knockback2',[RootBone] 'move');
		
		//Harry used to freeze when getting hit by something and casting at the same time -AdamJD		
		if (bPlayerCasting)
		{
			gotostate('PlayerWalking'); 
		}
	
//		sleep(0.5);
	
		enable('AnimEnd');
//		bPressedJump = false;
//		gotostate('PlayerWalking');

		Acceleration *= vect(0,0,1);
}

//********************************************************************************************
state hit_InstantPitDeath
{
	begin:
		disable('AnimEnd');
		DebugState();
		bThrow = false;

		if(rectarget!=none)
			rectarget.destroy();

		//If we're carrying an item, toss it forward a bit.  At this point, we'll assume it's
		// a firecracker
		if( CarryingActor != none )
			DropCarryingActor();

		bHidden = true;

}

//********************************************************************************************
state ChessDeath
{


	begin:
		DebugState();
		KillHarry(true);
/*		PlaySound( HurtSound[ Rand(NUM_HURT_SOUNDS) ] );
		playanim('knockback2');
		finishanim();
	
//		sleep(1.0);
		goto 'begin';*/
	
}
//********************************************************************************************
function DropCarryingActor()
{
	local vector v;

	//Uh, this may collide with harry.

	CarryingActor.SetPhysics( PHYS_FALLING );
	
	v = vect(0,0,125);

	CarryingActor.Velocity = v;
	SetCarryingActor(none);
}

//********************************************************************************************
state PickingUpWizardCard
{
	ignores AltFire;

	event PlayerTick( float DeltaTime )
	{
		aForward = 0;
		aStrafe  = 0;
		aLookup  = 0;
		aTurn    = 0;
		
		//turn off spell cursor if picking up wizard card -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}
	}

	function AnimEnd()
	{
		if (animsequence == 'wizardcardcollect')
		{
			EndPickup();
		}
	}

	function EndPickup()
	{
		if (!bEnded)
		{
			bEnded = true;
			GroundSpeed = fOldGroundSpeed;
//			basehud(myhud).DebugString2 = "Leaving Picking up wizard card " $LastState;
			cam.gotostate('StandardState');
			// RestoreStateName(); //not needed -AdamJD
		}
	}

	function BeginState()
	{
		bEnded = false;
	}

	function EndState()
	{
		EndPickup();
	}

begin:
	DebugState();
//	basehud(myhud).DebugString2 = "in Picking up wizard card";
	velocity = vect(0, 0, 0);
	if (GroundSpeed != 0)
	{
		fOldGroundSpeed = GroundSpeed;
	}
	GroundSpeed = 0;
	cam.gotostate('RotateAroundHarry');
	PlayAnim('wizardcardcollect');
	FinishAnim(); //let Harry finish the anim -AdamJD
	DesiredRotation.Yaw = ViewRotation.Yaw; //fixes the bug where Harry walked with his face down toward the ground after jumping into a card -AdamJD
	DesiredRotation.Pitch = ViewRotation.Pitch; //fixes the bug where Harry walked with his face down toward the ground after jumping into a card -AdamJD
	gotoState('PlayerWalking'); //go back to the PlayerWalking state -AdamJD
}
//********************************************************************************************
//old not needed retail playeraiming state -AdamJD
/*state playeraiming
{

ignores SeePlayer, HearNoise, Bump;
	

	// AE:
	function StartSoundFX()
	{
		PlaySound(sound'HPSounds.Magic_sfx.spell_build_nl2', SLOT_Misc);
		PlaySound(sound'HPSounds.Magic_sfx.spell_loop_nl', SLOT_Interact);
	}

	// AE:
	function StopSoundFX()
	{
		// Just in case this hasn't finished yet.
		StopSound(sound'HPSounds.Magic_sfx.spell_build_nl2', SLOT_Misc);

		StopSound(sound'HPSounds.Magic_sfx.spell_loop_nl', SLOT_Interact);
	}
	
	function BeginState()
	{
		//setphysics(phys_rotating);
		DebugState();
		fTimeToStop = 0.0;

//		basehud(myhud).DebugString2 = "in playeraiming";

		bOldStrafingState = (bStrafe != 0);

		MovementMode(false);
		
		// if ( bPressedJump )
		// {
			// DoJump();			// jumping
			// bPressedJump = false;
			// return;
		// }
		//PlaySound(sound'HPSounds.Magic_sfx.HAR_raise_arm', SLOT_Misc);

		StartSoundFX();
	}
	
	function EndState()
	{
		// AE:
		StopSoundFX();

		WalkBob = vect(0,0,0);
		bIsCrouching = false;
		//setphysics(phys_walking);

		if (!bOldStrafingState)
		{
			MovementMode(false);
		}

		//bStrafe = 0;
		//bLockedOnTarget = false;
		//BossTarget = none;

		rectarget.destroy();
		disable('AnimEnd');
//		basehud(myhud).DebugString2 = "out of playeraiming";
		bJustFired = false;
		bJustAltFired =  false;
		
		basewand(weapon).bCasting=false;	
		
		// if ( bPressedJump )
		// {
			//DoJump();			// jumping
			// bPressedJump = false;
		// }
	}

	exec function AltFire( optional float F )
	{

	}

	function AnimEnd()
	{
	}
			
	event PlayerTick( float DeltaTime )
	{
		local baseChar a;

		if ( bUpdatePosition )
			ClientUpdatePosition();

		PlayerMove(DeltaTime);
		
		bOldStrafingState = (bStrafe != 0);

		MovementMode(true);
		
		// if ( bPressedJump )
		// {
			// DoJump();			// jumping
			// PlayAnim('Jump');
			// bPressedJump = false;
			// gotostate('playeraiming');
		// }
	}
	
	function PlayerMove( float DeltaTime )
	{
		local vector X,Y,Z, NewAccel;
		local EDodgeDir OldDodge;
		local eDodgeDir DodgeMove;
		local rotator OldRotation;
		local float Speed2D;
		local bool	bSaveJump;
		local name AnimGroupName;

		GetAxes(Rotation,X,Y,Z);

		aForward *= 0.08;
		
		if( Physics == PHYS_Falling || bLockedOnTarget)
		{
			aStrafe  *= 0.4;
			aTurn = 0;
		}
		else
		{
			aStrafe = 0;
			aTurn    *= 0.24;
		}

		//aLookup  *= 0.24;
		aLookup  *= 0;			// make harry steady (no pitching with look up)

		// Update acceleration.
		if( bLockedOnTarget )
			NewAccel = aForward*X + aStrafe*Y;
		else
		{
			fTimeToStop -= DeltaTime;

			if (fTimeToStop < 0)
			{
				NewAccel = vect(0,0,0);
			}
			else
			{
				NewAccel = aForward*X + aStrafe*Y; 
				NewAccel.Z = 0;
			}
		}

		AnimGroupName = GetAnimGroup(AnimSequence);		

		if ( (Physics == PHYS_Walking) )
			Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);

		// Update rotation.
		OldRotation = Rotation;
		
		UpdateRotation(DeltaTime, 1);

		//If you're in "lock on target" mode, just set yaw to point to your target
		if( bLockedOnTarget )// &&  BossTarget != none )
			UpdateRotationToTarget();

		ProcessMove(DeltaTime, NewAccel, DodgeMove, OldRotation - Rotation);
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)	
	{
		local vector OldAccel;

		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );

//		log("In player aiming " $fTimeToStop);
		if(bJustAltFired || bJustFired)
		{
			if( !bLockedOnTarget )
			{
				if (fTimeToStop < 0)
				{
//					Velocity = vect(0,0,0);
					return;
				}
				else
				{
					return;
				}
			}
			else // else, set animation based on which way you're running.
			{
				return;
			}
		}

		// if ( bPressedJump )
		// {
			// DoJump();			// jumping
			// bPressedJump = false;
		// }
		if ( (Physics == PHYS_Walking)  )
		{
			if ( !bIsCrouching )
			{
				if ( (!bAnimTransition || (AnimFrame > 0)) && (GetAnimGroup(AnimSequence) != 'Landing') )
				{
					if ( Acceleration != vect(0,0,0) )
					{
						if ( (GetAnimGroup(AnimSequence) == 'Waiting')  )
						{
							bAnimTransition = true;
							TweenToRunning(0.1);
						}

						///bPlayerWalking = true;
					}
			 		else if ( (Velocity.X * Velocity.X + Velocity.Y * Velocity.Y < 1000))
			 		{
			 			//if ( GetAnimGroup(AnimSequence) == 'Waiting' )
			 			//{
						//	if ( bIsTurning && (AnimFrame >= 0) ) 
						//	{
						//		bAnimTransition = true;
						//		PlayTurning();
						//	}
						//}
			 			//else
						
						///bPlayerWalking = false;

						if( !bIsTurning && (GetAnimGroup(AnimSequence) != 'Waiting')) 
						{
							bAnimTransition = true;
							TweenToWaiting(0.2);
						}
					}
				}
			}
		}
	}

	function moveForward()
	{
	}

	begin:
		clearMessages=true;
		DebugState();

		hpconsole(player.console).bspaceReleased=false;
		hpconsole(player.console).bSpacePressed = false;
		//if(baseWand(weapon).curSpell==class'spelldud')
		//{
		//}
		//else
		//{
			makeTarget();
		//}
		loopanim('wave', , 0.2); //Use the interp as the trans2wave

		basewand(weapon).bCasting=true;		//turn on the sparkles.

	loopaim:

		//setTarget();
		//if(hpconsole(player.console).bspaceReleased)
		if(bAltFire == 0)
		{

			// AE:
//			PlaySound(sound'HPSounds.Magic_sfx.spell_loop_nl', [Volume]0);
			StopSoundFX();

			playAnim('cast', 2.0, 0.1);

			if( bCastFastSpells )
			{
				AnimFrame = 0.09;
				AnimRate = 3;
			}

			//sleep(0.801/2.0);
			while( AnimFrame < 0.95 )
				sleep( 0.001 );

			basewand(weapon).bCasting=true;		//turn on the sparkles.
		
			gotostate('PlayerWalking');
		}
		sleep(0.001);
		goto 'loopaim';
		
}*/
//********************************************************************************************
//Old casting states set up by me (moved to cHarryAnimChannel class) -AdamJD
/*
state stateCasting
{
	begin:
	HarryAnimType = AT_Combine;
	LoopAnim('wave', 1.0, 0.2); 
	gotoState('PlayerWalking');
}

state stateCancelCasting
{
  begin:
	PlayAnim('cast', 1.0, 0.2); //can't find a way to play no anims... -AdamJD
	FinishAnim();

	StopCasting();	
	gotoState('PlayerWalking');
}

state stateCast
{
	function BeginState()
	{
  		PlayAnim('cast', 2.0, 0.1);
	}

  begin:
	FinishAnim();
	
	StopCasting();
	gotoState('PlayerWalking');
} 
*/
//********************************************************************************************
state PlayerWalking
{
ignores SeePlayer, HearNoise, Bump; 

	function ZoneChange( ZoneInfo NewZone )
	{
		if (NewZone.bWaterZone)
		{
			setPhysics(PHYS_Swimming);
			GotoState('PlayerSwimming');
		}
	}

	function AnimEnd()
	{
		local name MyAnimGroup;
		local baseArea p;
		local hiddenarea hid;
		//	local baseArea.eAreaType aType;

		bAnimTransition = false;

		bJustFired = false;
		bJustAltFired= false;

		//clientMessage("HarryAnimEnd:"$AnimSequence);

		foreach allActors(class'baseArea', p)
		{
			hid=hiddenarea(p);
		
			if(hid.actorInBox( Self)==1)
			{
				bIsCrouching=True;
				hidden=true;
				stillDistance=hid.stillDistance;
				movingDistance=hid.movingDistance;
				hiddenDistance=stillDistance;
				break;
			}
			else
			{
				bIsCrouching=false;
				hidden=false;
			}		
		}

		if (Physics == PHYS_Walking)
		{			
			if (bIsCrouching)
			{
				if ( !bIsTurning && ((Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000) )
					PlayDuck();	
				else
					PlayCrawling();
			}
			else
			{
				MyAnimGroup = GetAnimGroup(AnimSequence);
				if ((Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000)
				{
					if ( MyAnimGroup == 'Waiting' )
						PlayWaiting();
					else
					{
						bAnimTransition = true;
						TweenToWaiting(0.4);
					}
				}	
				else if (bIsWalking)
				{
					if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing')   )
					{
						TweenToWalking(0.4);
						bAnimTransition = true;
					}
					else 
						PlayWalking();
				}
				
				else
				{
					if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing')  )
					{
						bAnimTransition = true;
						TweenToRunning(0.4);
					}
					else
						PlayRunning();
				}
			}
		}
		else
		{
			PlayInAir();
			
		}

	}
	
	function Landed(vector HitNormal)
	{
		clientMessage("landed: jump dist = " $VSize(Location-MountDelta) $ "   tia="$fTimeInAir);

		Global.Landed(HitNormal);

		PlayLandedSound();

		playanim('land1');
		
		//allow player to cast when landing -AdamJD
		if (bPlayerCasting)
		{
			HarryAnimType = AT_Combine;
			HarryAnimChannel.GotoStateCasting();
		}

//		log("PLOG PWalking landed");
	}
	
	//PlayerAim start and stop sound functons -AdamJD
	function StartSoundFX()
	{
		PlaySound(sound'HPSounds.Magic_sfx.spell_build_nl2', SLOT_Misc);
		PlaySound(sound'HPSounds.Magic_sfx.spell_loop_nl', SLOT_Interact);
	}

	function StopSoundFX()
	{
		StopSound(sound'HPSounds.Magic_sfx.spell_build_nl2', SLOT_Misc);
		StopSound(sound'HPSounds.Magic_sfx.spell_loop_nl', SLOT_Interact);
	}
	
	//turn on player casting -AdamJD
	function StartCasting()
	{
		//setup the casting stuff
		if (bPlayerCasting && CarryingActor == none ) //&& Physics == PHYS_Walking) //can now cast when jumping -AdamJD
		{
			//LoopAnim('wave', 2.0, 0.1);
			//MovementMode(true); //now not needed because you can now move the camera while casting! 
			Weapon.bPointing = true;
			basewand(weapon).bCasting=true;
			baseWand(Weapon).WandEffect.bHidden = false;
			bJustFired = false;
			bJustAltFired = false;
			hpconsole(player.console).bspaceReleased=false;
			hpconsole(player.console).bSpacePressed = false;
			StartSoundFX();
			makeTarget();
			//HarryAnimType = AT_Combine;
			HarryAnimChannel.GotoStateCasting();
			// bCastFastSpells = true; 
		}
		
		//go to the StopCasting function if the player has just pressed the wand input
		if( HarryAnimChannel.AnimSequence == 'cast' )
		{
			//LoopAnim('breath');
			StopCasting();
		}
	}
	
	//turn off player casting -AdamJD
	function StopCasting()
	{
		//if the player has just pressed the wand input then let Harry finish his anim and turn off the casting stuff until he has finished
		if( HarryAnimChannel.AnimSequence == 'cast' )
		{
			//LoopAnim('breath');
			HarryAnimChannel.GotoStateHasCast();
			Weapon.bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
			bPlayerCasting = false;
		}
		
		//otherwise stop the casting stuff altogether
		else
		{
			Weapon.bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
			//bJustFired = true;
			//bJustAltFired = true;
			bPlayerCasting = false;
			//gotoState('PlayerWalking');
			//HarryAnimType = AT_Combine;
			HarryAnimChannel.GotoStateCancelCasting();
			// bCastFastSpells = false; 
		}
	}
	
	event PlayerTick( float DeltaTime )
	{
		local baseChar a; 
		
		Global.PlayerTick( DeltaTime ); //update playertick -AdamJD
		
		foreach allActors(class'BaseCam', cam)
			break;
		
		if( bTempKillHarry )// ||  lifePotions <= 0 )
		{
			bTempKillHarry = false;
			KillHarry(true);
		}

		//Weird problem, not sure what's causing it, but sometimes when you touch a painzone, but start your climb
		// you'll end up with no health, but not in the dying state.  This "safely" takes care of that.
		if( lifePotions <= 0 )
		{
			KillHarry(true);
			return;
		}
		
		//stop casting if in cutscene/Harry is frozen -AdamJD
		if (baseHud(myhud).bCutSceneMode == true) 
		{
			if(bPlayerCasting == true)
			{
				bPlayerCasting = false;
				StopCasting();
				baseWand(weapon).bPointing = false;
				basewand(weapon).bCasting=false;
				baseWand(weapon).WandEffect.bHidden = true;
				rectarget.destroy();
				StopSoundFX();
			}
		}

		// if ( bUpdatePosition )
			// ClientUpdatePosition();

		//Try and save how long you've been falling, and what you're original height was when you started falling
		ProcessFalling( DeltaTime );

		PlayerMove(DeltaTime);

		//if( bStrafe != 0 )
		//	GotoState( 'PlayerAiming' );

		//if( hpconsole(player.console).bToggleMoveModePressed )
		//{
		//	hpconsole(player.console).bToggleMoveModePressed = false;
		//	bScreenRelativeMovement = !bScreenRelativeMovement;
		//	ClientMessage("ToggleTab");
		//}
		
		if( CarryingActor != none )
		{
			//r = weaponRot;
			//v = vect(0,0,1);
			//v = v >> r;
			CarryingActor.setLocation( weaponLoc );//- vect(0,0,1 );
			CarryingActor.SetRotation( weaponRot );

			//Also, look for a spacebar throw
			if( hpconsole(player.console).bSpacePressed )
			{
				hpconsole(player.console).bSpacePressed = false;
				AltFire(0);
			}
		}
		
		//the player wants to fire a spell, so let's see if they can -AdamJD
		if( bPlayerCasting && HarryAnimChannel.IsInState('stateCasting') && bAltFire == 0 ) //&& Physics == PHYS_Walking && GetAnimGroup(AnimSequence) == 'wave' //now not needed
		{
			//the player is aiming at a target or victim so cast the spell
			if ( rectarget.bIsLockedOn == true && (!IsInState('FallingMount')) || (!IsInState('Mounting')) || (!IsInState('MountFinish')) ) //don't cast the spell if Harry has just climbed something or is currently climbing
			{
				HarryAnimChannel.GotoStateCast();
				// StopSoundFX();
				//PlayAnim('cast', 2.0, 0.1);
				// Weapon.bPointing = false;
				// basewand(weapon).bCasting=false;
				// baseWand(Weapon).WandEffect.bHidden = true; 
				// rectarget.destroy();
				// bPlayerCasting = false;
				//MovementMode(false); //now not needed because you can now move the camera while casting! 
				StopCasting();
				//gotoState('PlayerWalking');
			}
			
			//the player is not aiming at a target or victim 
			else 
			{
				// Weapon.bPointing = false;
				// baseWand(Weapon).WandEffect.bHidden = true; 
				//loopanim('wave', 2.0 , 0.2);
				// HarryAnimChannel.GotoStateCancelCasting;
				// bPlayerCasting = false;
				// rectarget.destroy();
				//MovementMode(false); //now not needed because you can now move the camera while casting! 
				StopCasting();
				//gotoState('PlayerWalking');
			}
		}
		
		//HP2 cam code (keeps camera behind Harry) -AdamJD
		if( cam.IsInState('Standardstate') )
		{
			DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
			SetRotation( DesiredRotation );
		}
	}

	//Try and save how long you've been falling, and what you're original height was when you started falling
	//When you land, it uses this info to set the sound volume.
	function ProcessFalling( float DeltaTime )
	{
		if( Physics == PHYS_Falling )
		{
			if( eLastPhysState != PHYS_Falling )
				fFallingZ = Location.z;

			fTimeInAir += DeltaTime;
		}
		else
		{
			bPlayedFallSound = false;
			fTimeInAir = 0;
		}

		eLastPhysState = Physics;
	}

	function PlayerMove( float DeltaTime )
	{
		local vector X,Y,Z, NewAccel;
		local EDodgeDir OldDodge;
		local eDodgeDir DodgeMove;
		local rotator OldRotation;
		local rotator CamRot;
		local float Speed2D;
		local bool	bSaveJump;
		local name AnimGroupName;
		
		//find BaseCam -AdamJD
		foreach allActors(class'BaseCam', cam)
			break;
		
		// if( PotCam(ViewTarget) != none )
			// GetAxes(ViewTarget.Rotation,X,Y,Z);
		// else

		if( bReverseInput )  //Right now, just for troll chase.
		{
			//aForward = abs(aForward);
//			aForward *= -2;
			// @PAB always forward now
			aForward = abs(aForward * 2);
			aTurn = -aTurn;
			aStrafe = -aStrafe;
		}

		aForward  *= 0.08;

		if( Physics == PHYS_Falling  ||  bLockedOnTarget  ||  bFixedFaceDirection )
		{
			aStrafe   *= 0.08; //*2; //halved the speed of aStrafe -AdamJD
			aTurn = 0;
		}
		
		else
		{	
			aStrafe *= 0.08;	
			aTurn *= 0.24;	
		}

		aLookup   *= 0;			// make harry steady (no pitching with look up)
		aSideMove *= 0.1; 

		// Update acceleration.
		if( bLockedOnTarget  ||  bFixedFaceDirection )
		{
			//not needed -AdamJD
			// if( aForward < 0 )
				// aForward *= 2;
				
			//stop Harry turning on his own axis when fighting troll or vold -AdamJD
			aTurn = 0;
			
			//ClientMessage("aForward:" @ aForward @ "   aStrafe:" @ aStrafe);
			//NewAccel = aForward*X + aStrafe*Y;
			//ProcessAccel messes with aForward and aStrafe to get a final NewAccel
			NewAccel = ProcessAccel();
		}
		else
		{
			GetAxes(Rotation,X,Y,Z);

			// Update acceleration.
			if( bScreenRelativeMovement )
			{
				GetAxes(cam.Rotation,X,Y,Z);
				//NewAccel = vect(1,0,0)*aForward + vect(0,1,0)*aSideMove; 
				NewAccel = aForward*X + aSideMove*Y; 

				//If there's no acceleration, do nothing, otherwise harry snaps back to X
				if( NewAccel != vect(0,0,0) )
				{
					CamRot = cam.Rotation;
					CamRot.Pitch = 0;
					//NewAccel = NewAccel << CamRot;
					ScreenRelativeMovementYaw = (Rotator(NewAccel)).Yaw;
					//ClientMessage( " " @ ScreenRelativeMovementYaw );
				}
			}
			else
			{
				NewAccel = aForward*X + aStrafe*Y; 
			}
		}
		
		//don't move if input is disabled -AdamJD
		if( bKeepStationary )
		{
			aForward = 0;
			aStrafe = 0;
		}
		
		NewAccel.Z = 0;
		// Check for Dodge move
		
		AnimGroupName = GetAnimGroup(AnimSequence);		

		if ( (Physics == PHYS_Walking) )
			Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);

		// Update rotation.
		OldRotation = Rotation;

	//not needed -AdamJD
		//When you're locked onto a target, or facing down a fixed direction, other rotation code is performed
		//if( !(bLockedOnTarget || bFixedFaceDirection) ) // &&  target != none )
			//UpdateRotation(DeltaTime, 1); 

		ProcessMove(DeltaTime, NewAccel, DodgeMove, OldRotation - Rotation);
		
		//HP2 cam code -AdamJD
		if( cam.IsInState('StandardState') || cam.IsInState('BossState') )
		{
			//Harry will always look at what the camera is looking at
			DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
			SetRotation( DesiredRotation );
		}
		
		//stop casting if in cutscene/Harry is frozen -AdamJD
		if (baseHud(myhud).bCutSceneMode == true) 
		{
			if(bPlayerCasting == true)
			{
				bPlayerCasting = false;
				StopCasting();
				baseWand(weapon).bPointing = false;
				basewand(weapon).bCasting=false;
				baseWand(weapon).WandEffect.bHidden = true;
				rectarget.destroy();
				StopSoundFX();
			}
		}
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)	
	{
		local vector OldAccel;

		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );

		if(bJustAltFired || bJustFired)
		{
			Velocity = vect(0,0,0);
			return;
		}
		
		//stop casting if in cutscene/Harry is frozen -AdamJD
		if (baseHud(myhud).bCutSceneMode == true) 
		{
			if(bPlayerCasting == true)
			{
				bPlayerCasting = false;
				StopCasting();
				baseWand(weapon).bPointing = false;
				basewand(weapon).bCasting=false;
				baseWand(weapon).WandEffect.bHidden = true;
				rectarget.destroy();
				StopSoundFX();
			}
		}

		if ( bPressedJump )
		{
			DoJump();			// jumping
			bPressedJump = false;
		}

		if ( (Physics == PHYS_Walking)  )
		{	
			if (!bIsCrouching)
			{
				if (bDuck != 0)
				{
					bIsCrouching = true;   // duck (to sneaking)
					PlayDuck();
				}
			}
			else if (bDuck == 0)
			{	
				OldAccel = vect(0,0,0);
				bIsCrouching = false;		// sneak to run
				TweenToRunning(0.1);
			}
			if ( !bIsCrouching )
			{
				if ( (!bAnimTransition || (AnimFrame > 0)) && (GetAnimGroup(AnimSequence) != 'Landing') )
				{
					if ( Acceleration != vect(0,0,0) )
					{
						if ( (GetAnimGroup(AnimSequence) == 'Waiting')  )
						{
							bAnimTransition = true;
							TweenToRunning(0.1);
						}

						///bPlayerWalking = true;
					}
			 		else if ( (Velocity.X * Velocity.X + Velocity.Y * Velocity.Y < 1000))
			 		{
			 			//if ( GetAnimGroup(AnimSequence) == 'Waiting' )
			 			//{
						//	if ( bIsTurning && (AnimFrame >= 0) ) 
						//	{
						//		bAnimTransition = true;
						//		PlayTurning();
						//	}
						//}
			 			//else
						
						///bPlayerWalking = false;

						if( !bIsTurning && (GetAnimGroup(AnimSequence) != 'Waiting')) 
						{
							bAnimTransition = true;
							TweenToWaiting(0.2);
						}
					}
				}
			}
			else
			{
				if ( (OldAccel == vect(0,0,0)) && (Acceleration != vect(0,0,0)) )
					PlayCrawling();
			 	else if ( !bIsTurning && (Acceleration == vect(0,0,0)) && (AnimFrame > 0.1) )
					PlayDuck();
			}
		}
	}

	function BeginState()
	{
		DebugState();

//		log("PLOG PWalking Entered");
		if ( Mesh == None )
			SetMesh();
		WalkBob = vect(0,0,0);
		DodgeDir = DODGE_None;
		bIsCrouching = false;
		bIsTurning = false;
		bPressedJump = false;
		if (Physics != PHYS_Falling) SetPhysics(PHYS_Walking);
		if ( !IsAnimating() )
			PlayWaiting();
		
		//now not needed -AdamJD
		/*
		//AdamJD code start 
		//can't get camera to move when Harry is casting so this is a hack 
		if( !bLockedOnTarget )
		{
			if (bPlayerCasting == true)
			{
				MovementMode(true);
			}
		}
		//AdamJD End
		*/
		
		// foreach allActors(class'BaseCam', cam)
			// break;

		// LastWalkYaw = Rotation.yaw;
		// PlayerMoving = MOVING_NOT;
		// CamPosYawOffset = 0;
		// CamTargetYawOffset = 0;
	}
		
	function EndState()
	{
//		log("PLOG PWalking Exited");
		WalkBob = vect(0,0,0);
		bIsCrouching = false;
		
		//stop casting if in cutscene/Harry is frozen -AdamJD
		if (baseHud(myhud).bCutSceneMode == true) 
		{
			if(bPlayerCasting == true)
			{
				bPlayerCasting = false;
				baseWand(weapon).bPointing = false;
				basewand(weapon).bCasting=false;
				baseWand(weapon).WandEffect.bHidden = true;
				rectarget.destroy();
				StopSoundFX();
			}
		}
		
		//now not needed -AdamJD
		/*
		//if not casting go back to normal movement -AdamJD
		if (bPlayerCasting == false)
		{
			MovementMode(false);
		}
		*/
	}
}

//********************************************************************************************
state ChessMode
{
ignores SeePlayer, HearNoise, Bump;

	exec function AltFire( optional float F )
	{
	}

	function AnimEnd()
	{
		local name MyAnimGroup;
		local baseArea p;
		local hiddenarea hid;
		//	local baseArea.eAreaType aType;

		bAnimTransition = false;

		bJustFired = false;
		bJustAltFired= false;

		foreach allActors(class'baseArea', p)
		{
			hid=hiddenarea(p);
		
			if(hid.actorInBox( Self)==1)
			{
				bIsCrouching=True;
				hidden=true;
				stillDistance=hid.stillDistance;
				movingDistance=hid.movingDistance;
				hiddenDistance=stillDistance;
				break;
			}
			else
			{
				bIsCrouching=false;
				hidden=false;
			}		
		}
		
		if (Physics == PHYS_Walking)
		{
			if (bIsCrouching)
			{
				if ( !bIsTurning && ((Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000) )
					PlayDuck();	
				else
					PlayCrawling();
			}
			else
			{
				MyAnimGroup = GetAnimGroup(AnimSequence);
				if ((Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000)
				{
					if ( MyAnimGroup == 'Waiting' )
						PlayWaiting();
					else
					{
						bAnimTransition = true;
						TweenToWaiting(0.2);
					}
				}	
				else if (bIsWalking)
				{
					if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing') )
					{
						TweenToWalking(0.1);
						bAnimTransition = true;
					}
					else 
						PlayWalking();
				}
				else
				{
					if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing') )
					{
						bAnimTransition = true;
						TweenToRunning(0.1);
					}
					else
						PlayRunning();
				}
				
			}
		}
		
		else
		{
			PlayInAir();
			
		}
		

	}
	
	event PlayerTick( float DeltaTime )
	{
		local baseChar a;
		
		if( bTempKillHarry )
		{
			bTempKillHarry = false;
			KillHarry(true);
		}

		if ( bUpdatePosition )
			ClientUpdatePosition();

		PlayerMove(DeltaTime);

		if( CarryingActor != none )
		{
			CarryingActor.setLocation( weaponLoc );//- vect(0,0,1 );
			CarryingActor.SetRotation( weaponRot );
		}
		
		//stop casting on chess board -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}
	}
	
	//new rotation function for the chess board -AdamJD
	function UpdateRotationOnChessBoard(float DeltaTime, float maxPitch)
	{
		local rotator	NewRotation;
		local float		YawVal;
	
		//get the SmoothMouseX axis and cap it to not overshoot input (only need to care about the SmoothMouseX axis) -AdamJD
		YawVal = (SmoothMouseX / 1.5) * DeltaTime; 
		
		//limit SmoothMouseX -AdamJD 		
		if(YawVal == SmoothMouseX)
		{
			if( YawVal > MAX_MOUSE_DELTA_X )		
			{
				YawVal = MAX_MOUSE_DELTA_X;
			}
				
			else if( YawVal < MIN_MOUSE_DELTA_X ) 
			{
				YawVal = MIN_MOUSE_DELTA_X;
			}
		}
			
		ViewRotation.Yaw += YawVal; //set YawVal to ViewRotation.Yaw -AdamJD
		DesiredRotation.Yaw = ViewRotation.Yaw; //set ViewRotation.Yaw to DesiredRotation.Yaw -AdamJD
		NewRotation.Yaw = cam.rotation.Yaw; //move Harry and chess marker at the same time when moving mouse left or right -AdamJD

		DesiredRotation = ViewRotation; //set ViewRotation to DesiredRotation -AdamJD
		setRotation(NewRotation); //use the NewRotation as the camera rotation -AdamJD
	}

	function PlayerMove( float DeltaTime )
	{
		local vector X,Y,Z, NewAccel;
		local EDodgeDir OldDodge;
		local eDodgeDir DodgeMove;
		local rotator OldRotation;
		local rotator CamRot;
		local float Speed2D;
		local bool	bSaveJump;
		local name AnimGroupName;
		
		//if( PotCam(ViewTarget) != none )
		//	GetAxes(ViewTarget.Rotation,X,Y,Z);
		//else

		if (aForward < 0)
		{
			aForward = 0;
		}

		bPressedJump = false;

		if (bHarrysMove)
		{
			if (aForward > 0)
			{
				bChessMoving = true;
				TweenToRunning(0.4); //make Harry move smoothly -AdamJD
				return;
			}
		}
		else
		{
			return;
		}
		
		//not needed -AdamJD
		/*
		if( bReverseInput )  //Right now, just for troll chase.
		{
			aForward = -aForward;
			aTurn = -aTurn;
			aStrafe = -aStrafe;
		}

		aForward  *= 0.08;

		if( Physics == PHYS_Falling  || bLockedOnTarget)
		{
			aStrafe   *= 0.08*2;
			aTurn = 0;
		}
		else
		{
			aStrafe = 0;
			aTurn    *= 0.24;
		}
		*/

		aLookup   *= 0;			// make harry steady (no pitching with look up)
		// aSideMove *= 0.1; //not needed -AdamJD

		if( bKeepStationary )
		{
			aForward = 0;
			aStrafe = 0;
		}
		
		//not needed -AdamJD
		/*
		// Update acceleration.
		if( bLockedOnTarget  )
		{
			if( aForward < 0 ) 
				aForward *= 2;

			ClientMessage("aForward:" @ aForward @ "   aStrafe:" @ aStrafe);
			NewAccel = aForward*X + aStrafe*Y;
			ProcessAccel messes with aForward and aStrafe to get a final NewAccel
			NewAccel = ProcessAccel();
		}*/
		// else  //not needed -AdamJD
		// {
			GetAxes(Rotation,X,Y,Z);

			// Update acceleration.
			if( bScreenRelativeMovement )
			{
				GetAxes(cam.Rotation,X,Y,Z);
				//NewAccel = vect(1,0,0)*aForward + vect(0,1,0)*aSideMove; 
				NewAccel = aForward*X + aSideMove*Y; 

				//If there's no acceleration, do nothing, otherwise harry snaps back to X
				if( NewAccel != vect(0,0,0) )
				{
					CamRot = cam.Rotation;
					CamRot.Pitch = 0;
					//NewAccel = NewAccel << CamRot;
					ScreenRelativeMovementYaw = (Rotator(NewAccel)).Yaw;
					//ClientMessage( " " @ ScreenRelativeMovementYaw );
				}
			}
			else
			{
				NewAccel = aForward*X + aStrafe*Y; 
			}
		// }

		NewAccel.Z = 0;
		// Check for Dodge move
		
		AnimGroupName = GetAnimGroup(AnimSequence);		
		if ( (Physics == PHYS_Walking) )
			Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);

		//not needed -AdamJD
		// Update rotation.
		// OldRotation = Rotation;
		
		//When you're locked onto a target, other rotation code is performed
		//if( !bLockedOnTarget ) // &&  target != none ) 
			//UpdateRotation(DeltaTime, 1); 
			
		UpdateRotationOnChessBoard(DeltaTime, 1); //new rotation function created by me just for the chess board -AdamJD
		
		//stop casting on chess board -AdamJD
		if(bPlayerCasting == true)
		{
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}

		// ProcessMove(DeltaTime, NewAccel, DodgeMove, OldRotation - Rotation); //commented out because this allows Harry to walk off the chess board breaking the game... -AdamJD
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)	
	{
		local vector OldAccel;

		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );

		if(bJustAltFired || bJustFired)
		{
			Velocity = vect(0,0,0);
			return;
		}

		if ( bPressedJump )
		{
			DoJump();			// jumping
			bPressedJump = false;
		}

		if ( (Physics == PHYS_Walking)  )
		{
			if (!bIsCrouching)
			{
				if (bDuck != 0)
				{
					bIsCrouching = true;   // duck (to sneaking)
					PlayDuck();
				}
			}
			else if (bDuck == 0)
			{	
				OldAccel = vect(0,0,0);
				bIsCrouching = false;		// sneak to run
				TweenToRunning(0.1);
			}

			if ( !bIsCrouching )
			{
				if ( (!bAnimTransition || (AnimFrame > 0)) && (GetAnimGroup(AnimSequence) != 'Landing') )
				{
					if ( Acceleration != vect(0,0,0) )
					{
						if ( (GetAnimGroup(AnimSequence) == 'Waiting')  )
						{
							bAnimTransition = true;
							TweenToRunning(0.1);
						}

						///bPlayerWalking = true;
					}
			 		else if ( (Velocity.X * Velocity.X + Velocity.Y * Velocity.Y < 1000))
			 		{
			 			//if ( GetAnimGroup(AnimSequence) == 'Waiting' )
			 			//{
						//	if ( bIsTurning && (AnimFrame >= 0) ) 
						//	{
						//		bAnimTransition = true;
								//PlayTurning();
						//	}
						//}
			 			//else
						
						///bPlayerWalking = false;

						if( !bIsTurning && (GetAnimGroup(AnimSequence) != 'Waiting')) 
						{
							bAnimTransition = true;
							TweenToWaiting(0.2);
						}
					}
				}
			}
			
			//stop casting on chess board -AdamJD
			if(bPlayerCasting == true)
			{
				bPlayerCasting = false;
				StopCasting();
				baseWand(weapon).bPointing = false;
				basewand(weapon).bCasting=false;
				baseWand(Weapon).WandEffect.bHidden = true;
				rectarget.destroy();
				StopSoundFX();
			}
			
			else
			{
				if ( (OldAccel == vect(0,0,0)) && (Acceleration != vect(0,0,0)) )
					PlayCrawling();
			 	else if ( !bIsTurning && (Acceleration == vect(0,0,0)) && (AnimFrame > 0.1) )
					PlayDuck();
			}
		}
	}
	
	//stop Harry moving and casting when first on the chess board -AdamJD
	function BeginState()
	{
		Acceleration = Vec(0, 0, 0);
		Velocity = Vec(0, 0, 0);
		
		if (Physics == PHYS_Falling) 
		{
			SetPhysics(PHYS_Walking);
			PlayWalking();
		}
		
		else if (bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
			PlayWalking();
			HarryAnimType = AT_Replace;
		}
		
		else
		{
			PlayWalking();
		}
	}
	
	function EndState()
	{
		WalkBob = vect(0,0,0);
		bIsCrouching = false;
		
		//stop casting on chess board -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}
	}

begin:
		DebugState();

		if ( Mesh == None )
			SetMesh();
		WalkBob = vect(0,0,0);
		DodgeDir = DODGE_None;
		bIsCrouching = false;
		bIsTurning = false;
		bPressedJump = false;
		if (Physics != PHYS_Falling) SetPhysics(PHYS_Walking);
		if ( !IsAnimating() )
			PlayWaiting();
		
		//stop casting on chess board -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}

		foreach allActors(class'BaseCam', cam)
			break;

loop:
		if (bHarrysMove)
		{
			if (bChessMoving && ChessTargetLocation != vect(0, 0, 0))
			{
				PlayWalking();
				moveto(ChessTargetLocation);

				if (vsize(velocity) == 0)
				{
					LoopAnim('breath', 0.4 + 0.4 * FRand(), 0.25, , HarryAnimType);
					bHarrysMove = false;
					bChessMoving = false;
					DesiredRotation = rot(0, 0, 0);
				}
			}
		}
		sleep(0.01);
		goto 'loop';
}

//**********************************************************************************************
//now not needed -AdamJD
/*
//This is called from 'PlayerWalking' and 'PlayerAim'
function UpdateRotation(float DeltaTime, float maxPitch)
{
	local rotator newRotation;
	local float   YawVal;
	local float   YawValY; //local YawValY float -AdamJD
	local int     RotDist;
	local float   FastRotRate;

	if( Physics == PHYS_Falling )
		return;

	FastRotRate = 70000;
	
	YawValY = YawVal; //set YawValY to YawVal -AdamJD

	DesiredRotation = ViewRotation;
	ViewRotation.Pitch += 32.0 * DeltaTime * aLookUp;
	ViewRotation.Pitch = ViewRotation.Pitch & 65535;
	
	if ((ViewRotation.Pitch > 18000) && (ViewRotation.Pitch < 49152))
	{
		if (aLookUp > 0) 
			ViewRotation.Pitch = 18000;
		else
			ViewRotation.Pitch = 49152;
	}

	if(aturn>turnRate)
		aturn=turnRate;
	else
	if(aturn<-turnRate)
		aturn=-turnRate;
	
	//Special rot for when you're in state 'PlayerWalking' and bScreenRelativeMovement
	if( IsInState('PlayerWalking') && bScreenRelativeMovement )
	{
		//Need to zip on round to ScreenRelativeMovementYaw
		// ( or just snap to the direction )
		RotDist = (ScreenRelativeMovementYaw - ViewRotation.yaw)%65536;
		
		//force the turn
		//YawVal = RotDist;

		if( RotDist < 32768 )
		{
			YawVal = FastRotRate * DeltaTime;
			if( YawVal > RotDist )
				YawVal = RotDist;
		}
		else
		{
			RotDist = 65536 - RotDist;
			YawVal = FastRotRate * DeltaTime;
			if( YawVal > RotDist )
				YawVal = RotDist;
			YawVal = -YawVal;
		}
	}
	
	else
	{
		// When you're in state 'PlayerAim', and you're in "circle around the boss" (bLockedOnTarget) mode, this function gets called,
		// and then overridden, with an absolute rot set towards the Boss.
		
		if(Acceleration == vect(0,0,0)) 
		{
			//YawVal= 32.0 * DeltaTime * aTurn; //old retail code -AdamJD
			
			//HOLY CRAP- I finally fixed Harry turning when strafing!!! -AdamJD
			YawVal= (SmoothMouseX / 1.5) * DeltaTime; 
			// YawValY = (SmoothMouseY / 1.5) * DeltaTime;
			
			//for a more smoother Mouse X effect -AdamJD
			if(YawVal == SmoothMouseX)
			{
				if( YawVal > MAX_MOUSE_DELTA_X )		
				{
					YawVal = MAX_MOUSE_DELTA_X;
				}
				
				else if( YawVal < MIN_MOUSE_DELTA_X ) 
				{
					YawVal = MIN_MOUSE_DELTA_X;
				}
			}
			
			//for a more smoother Mouse Y effect -AdamJD
			// if(YawValY == SmoothMouseY)
			// {
				// if( YawValY > MAX_MOUSE_DELTA_Y )		
				// {
					// YawValY = MAX_MOUSE_DELTA_Y;
				// }
				
				// else if( YawValY < MIN_MOUSE_DELTA_Y ) 
				// {
					// YawValY = MIN_MOUSE_DELTA_Y;
				// }
			// }
			
			//keep camera behind Harry -AdamJD
			// DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
			// SetRotation( DesiredRotation ); 
		}
		
		else
		{
			//YawVal=24.0 * DeltaTime * aTurn; //old retail code -AdamJD
			
			//HOLY CRAP- I finally fixed Harry turning when strafing!!! -AdamJD
			YawVal= (SmoothMouseX / 1.8) * DeltaTime; 
			// YawValY = (SmoothMouseY / 1.8) * DeltaTime;
			
			//for a more smoother Mouse X effect -AdamJD
			if(YawVal == SmoothMouseX)
			{
				if( YawVal > MAX_MOUSE_DELTA_X )		
				{
					YawVal = MAX_MOUSE_DELTA_X;
				}
				
				else if( YawVal < MIN_MOUSE_DELTA_X ) 
				{
					YawVal = MIN_MOUSE_DELTA_X;
				}
			}
			
			//for a more smoother Mouse Y effect -AdamJD
			// if(YawValY == SmoothMouseY)
			// {
				// if( YawValY > MAX_MOUSE_DELTA_Y )		
				// {
					// YawValY = MAX_MOUSE_DELTA_Y;
				// }
				
				// else if( YawValY < MIN_MOUSE_DELTA_Y ) 
				// {
					// YawValY = MIN_MOUSE_DELTA_Y;
				// }
			// }
			
			//keep camera behind Harry -AdamJD
			// DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
			// SetRotation( DesiredRotation ); 
		}
	}
	
	//If bConstrainYaw is set and you're not turning, this tries to turn you back towards the x axis
	if( bConstrainYaw  &&  yawVal == 0 )
	{
		ViewRotation.Yaw = ViewRotation.Yaw & 65535;

		RotDist = 5500.0*deltaTime;
		
		if( ViewRotation.Yaw < 32767 )
			yawVal = -min(  RotDist,         ViewRotation.Yaw );
		else
			yawVal =  min(  RotDist, 65536 - ViewRotation.Yaw );
	}
	
	//AdamJD
	ViewRotation.Yaw += yawVal;
	//ViewRotation.Pitch = YawValY;

	//This is specially for keeping harry pointing down a specified yaw, with a certain amount of variance.  For now, it's hard coded down the x axis.
	if( bConstrainYaw )
	{
		ViewRotation.Yaw = ViewRotation.Yaw & 65535;

		if( ViewRotation.Yaw <  32767  &&  ViewRotation.Yaw > ConstrainYawVariance )
			ViewRotation.Yaw = ConstrainYawVariance;
		else
		if( ViewRotation.Yaw >= 32767  &&  ViewRotation.Yaw < 65536 - ConstrainYawVariance )
			ViewRotation.Yaw = 65536 - ConstrainYawVariance;
	}
	
	// Remember pre-shake.
	newRotation = ViewRotation;
	ViewShake(deltaTime);
	if( ViewTarget != none )
	{
		//Apply the view shake delta to our camera actor.
		newRotation = ViewTarget.Rotation + ViewRotation - newRotation;
		newRotation.Roll = newRotation.Roll & 0xffff;
		ViewTarget.SetRotation(newRotation);
	}

	newRotation = Rotation;
	newRotation.Yaw = ViewRotation.Yaw;
	newRotation.Pitch = ViewRotation.Pitch;
	
	if ( (newRotation.Pitch > maxPitch * RotationRate.Pitch) && (newRotation.Pitch < 65536 - maxPitch * RotationRate.Pitch) )
	{
		if (ViewRotation.Pitch < 32768) 
			newRotation.Pitch = maxPitch * RotationRate.Pitch;
		else
			newRotation.Pitch = 65536 - maxPitch * RotationRate.Pitch;
	}
	setRotation(newRotation);
}*/
//**********************************************************************************************
//old x mouse function created by me -AdamJD
/*
function MouseX(float DeltaTime)
{
	local float xMouse;
	local float fRotSpeed;
	local float fCurrentMinPitch;
	local float fCurrentMaxPitch;
	
	xMouse = SmoothMouseX * DeltaTime;
	
	fRotSpeed = 4.0f;
	fCurrentMinPitch = -14000.0f;	
	fCurrentMaxPitch = 14000.0f;
			
	//for a more smoother effect -AdamJD
	if( xMouse > MAX_MOUSE_DELTA_X )
	{
		xMouse = MAX_MOUSE_DELTA_X;
	}
		
	else if( xMouse < MIN_MOUSE_DELTA_X ) 
	{
		xMouse = MIN_MOUSE_DELTA_X;
	}
		
	//DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
	// SetRotation( DesiredRotation );
}*/
//**********************************************************************************************
//old y mouse function created by me -AdamJD
/*
function MouseY(float DeltaTime)
{
	local float yMouse;
	local float fRotSpeed;
	local float fCurrentMinPitch;
	local float fCurrentMaxPitch;
			
	yMouse = SmoothMouseY * DeltaTime;
	
	fRotSpeed = 4.0f;
	fCurrentMinPitch = -14000.0f;	
	fCurrentMaxPitch = 14000.0f;
			
	//for a more smoother effect -AdamJD
	if( yMouse > MAX_MOUSE_DELTA_X )
	{
		yMouse = MAX_MOUSE_DELTA_X;
	}
		
	else if( yMouse < MIN_MOUSE_DELTA_X ) 
	{
		yMouse = MIN_MOUSE_DELTA_X;
	}
		
	//DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
	// SetRotation( DesiredRotation );
}*/
//**********************************************************************************************
function UpdateRotationToTarget()
{
	local rotator  r;
	local vector	v;

	local vector	TargetLoc;

	if( bFixedFaceDirection )
	{
		//ViewRotation.Yaw = ViewRotation.Yaw & 65535;
		//RotDist = 5500.0*deltaTime;
		//if( ViewRotation.Yaw < 32767 )
		//	yawVal = -min(  RotDist,         ViewRotation.Yaw );
		//else
		//	yawVal =  min(  RotDist, 65536 - ViewRotation.Yaw );
		//ViewRotation.Yaw += yawVal;
		r = Rotator( vFixedFaceDirection );
		r.pitch = 0;
		r.roll = 0;
		SetRotation( r );
		ViewRotation = r;
	}
	else
	if( BossTarget != none )
	{
		TargetLoc = BossTarget.Location;

		//This makes it so when harry goes to state 'hit', he still looks at the boss.
		DesiredRotation = ViewRotation;
		
		//not needed -AdamJD
		/*if(   (StandardTarget.Location != TargetLoc && astrafe != 0)
			|| (BossRailMove(BossTarget) != none)
		  )
		{
			v = Normal(Location - TargetLoc) * 10;
			v = StandardTarget.Location - v;

			if (VSize(v) < 10)
			{
				v = TargetLoc;
			}
			StandardTarget.SetLocation(v);
		}*/

		r = rotator(StandardTarget.Location - Location);
		r.pitch = Rotation.pitch;
		//SetRotation( r ); //not needed -AdamJD
		ViewRotation = r;
		DesiredRotation = r; //set the desired rotation -AdamJD
	}
	//not needed -AdamJD
	/*
	else
	{
		TargetLoc = rectarget.location;

		r = rotator(StandardTarget.Location - Location);
		r.pitch = Rotation.pitch;
		SetRotation( r );
		ViewRotation = r;
	}
	*/
}

//**********************************************************************************************
function vector ProcessAccel()
{
	local float d;
	local vector v;
	local vector X, Y, Z;
	local vector x2, y2;
	local float xMag, yMag;
	local BossRailMove  b;
	local vector n;//, side;

	//Safety hack:  Keep track of the highest aForward we've ever seen
	if( aForward > fLargestAForward )
		fLargestAForward = aForward;

	//Point harry at our foe
	UpdateRotationToTarget(); 

	GetAxes(Rotation,X,Y,Z);

	//Boss Fighting: case: Boss on rail, both inside a 'rect'
	// If you're locked on a target, and it's a boss who you're circling around
	if(   bLockedOnTarget
	   && BossRailMove(BossTarget) != none
	  )
	{
		b = BossRailMove(BossTarget);

		//Push away from our foe as we move
		//xMag = aForward - (fLargestAForward*0.40);
		xMag = aForward;
		yMag = aStrafe;

		//If you're strafeing, push away
		xMag -= abs(aStrafe) * 0.25;

		v = xMag*X + yMag*Y;

		//Look at the top of BossRailMove for what these are
		//left
		v = KeepPawnInsidePlane(v, b.v1, -b.n2);
		//top
		v = KeepPawnInsidePlane(v, b.v1,  b.n1);
		//right
		v = KeepPawnInsidePlane(v, b.v2,  b.n2);
		//bottom
		v = KeepPawnInsidePlane(v, b.v4, -b.n1);

		//Keep accel consistent
		if( (v.x!=0 || v.y!=0) && fLargestAForward != 0 )
			v = Normal( v ) * fLargestAForward;
	}
	else
	{
		v = aForward*X + aStrafe*Y;
	}

	v += vAdditionalAccel;
	vAdditionalAccel = vect(0,0,0);

	return v;
}

//**********************************************************************************************
//Takes your current vAccel, and modifies it to keep you on the back side of the supplied plane.
// Returns a new accel that will keep you there.
function vector KeepPawnInsidePlane(vector vAccel, vector vPlanePoint, vector vPlaneNormal)
{
	local float d;
	local vector x2, y2;
	local float xMag, yMag;

	//vPlaneNormal = -b.n2;

	d = (Location - vPlanePoint) dot vPlaneNormal;

	if( d > 0 )
	{
		//Get forward and side vectors
		x2 = -vPlaneNormal;
		y2 = vect(0,0,1)  cross  x2;

		//Get accel vector componants relative to the box
		xMag = (vAccel  dot  x2);
		yMag = (vAccel  dot  y2);
		
		//Scale x vector by how much you're out of the box, if you're moving away from the box
		if( xMag < 0 )
			xMag = d * 10;  //10, arbitrary scaler to make you move more quickly inwards, the further you are away.
	
		vAccel = x2*xMag + y2*yMag;
	}

	return vAccel;
}

//**********************************************************************************************
state GameEnded
{
	ignores SeePlayer, HearNoise, KilledBy, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, TakeDamage, PainTimer, Died;

}




function startmenu()
{

				hpconsole(player.console).bQuickKeyEnable = false;
				hpconsole(player.console).LaunchUWindow();



}


state exittoMenu
{

	begin:
//		sleep(0.5);
		Level.Game.RestartGame();
//		startmenu();
//		sleep(0.3);
		gotostate('harryfrozen');
}






state harryfrozen
{
ignores SeePlayer, HearNoise, Bump;

	exec function AltFire( optional float F )
		{
		}

	function ZoneChange( ZoneInfo NewZone )
	{
		if (NewZone.bWaterZone)
		{
			setPhysics(PHYS_Swimming);
			GotoState('PlayerSwimming');
		}
	}

	function AnimEnd()
	{
		local name MyAnimGroup;
		local baseArea p;
		local hiddenarea hid;
	//	local baseArea.eAreaType aType;

		bAnimTransition = false;

		bJustFired = false;
		bJustAltFired= false;

		foreach allActors(class'baseArea', p)
		{
			hid=hiddenarea(p);
		
			if(hid.actorInBox( Self)==1)
			{
				
				bIsCrouching=True;
				hidden=true;
				stillDistance=hid.stillDistance;
				movingDistance=hid.movingDistance;
				hiddenDistance=stillDistance;
				break;
			}
			else
			{
				
				bIsCrouching=false;
				hidden=false;
			
			}		
		}

		if (Physics == PHYS_Walking)
		{
			if (bIsCrouching)
			{
				if ( !bIsTurning && ((Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000) )
					PlayDuck();	
				else
					PlayCrawling();
			}
			else
			{

				MyAnimGroup = GetAnimGroup(AnimSequence);
				if ((Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000)
				{
					if ( MyAnimGroup == 'Waiting' )
						PlayWaiting();
					else
					{
						bAnimTransition = true;
						TweenToWaiting(0.2);
					}
				}	
				else if (bIsWalking)
				{
					if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing')   )
					{
						TweenToWalking(0.1);
						bAnimTransition = true;
					}
					else 
						PlayWalking();
				}
				else
				{
					if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing')  )
					{
						bAnimTransition = true;
						TweenToRunning(0.1);
					}
					else
						PlayRunning();
				}
			}
		}
		else
		{
			PlayInAir();
		}
			
	}

	function Landed(vector HitNormal)
	{
		clientMessage("landed");
		PlayLandedSound();
		Global.Landed(HitNormal);
	}

	
	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)	
	{
		local vector OldAccel;
		
	
		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );

		if(bJustAltFired || bJustFired)
		{
			Velocity = vect(0,0,0);
			return;
		}

		if ( (Physics == PHYS_Walking)  )
		{
			if (!bIsCrouching)
			{
				if (bDuck != 0)
				{
					bIsCrouching = true;   // duck (to sneaking)
					PlayDuck();
				}
			}
			else if (bDuck == 0)
			{	
				OldAccel = vect(0,0,0);
				bIsCrouching = false;		// sneak to run
				TweenToRunning(0.1);
			}

			if ( !bIsCrouching )
			{
				if ( (!bAnimTransition || (AnimFrame > 0)) && (GetAnimGroup(AnimSequence) != 'Landing') )
				{
					if ( Acceleration != vect(0,0,0) )
					{
						if ( (GetAnimGroup(AnimSequence) == 'Waiting')  )
						{
							bAnimTransition = true;
							TweenToRunning(0.1);
						}
					}
			 		else if ( (Velocity.X * Velocity.X + Velocity.Y * Velocity.Y < 1000))
			 		{
			 		/*	if ( GetAnimGroup(AnimSequence) == 'Waiting' )
			 			{
							if ( bIsTurning && (AnimFrame >= 0) ) 
							{
								bAnimTransition = true;
								PlayTurning();
							}
						}
			 			else*/
						if ( !bIsTurning && (GetAnimGroup(AnimSequence) != 'Waiting')) 
						{
							bAnimTransition = true;
							TweenToWaiting(0.2);
						}
					}
				}
			}
			else
			{
				if ( (OldAccel == vect(0,0,0)) && (Acceleration != vect(0,0,0)) )
					PlayCrawling();
			 	else if ( !bIsTurning && (Acceleration == vect(0,0,0)) && (AnimFrame > 0.1) )
					PlayDuck();
			}
		}
	}
			
	event PlayerTick( float DeltaTime )
	{
		if ( bUpdatePosition )
			ClientUpdatePosition();

		PlayerMove(DeltaTime);
	}

	function PlayerMove( float DeltaTime )
	{
		local vector X,Y,Z, NewAccel;
		local EDodgeDir OldDodge;
		local eDodgeDir DodgeMove;
		local rotator OldRotation;
		local float Speed2D;
		local bool	bSaveJump;
		local name AnimGroupName;

		GetAxes(Rotation,X,Y,Z);

		aForward *= 0.08;
		aStrafe  *= 0.4;
	//	aLookup  *= 0.24;
		aLookup  *= 0;			// make harry steady (no pitching with look up)
		aTurn    *= 0.24;

		// Update acceleration.
		NewAccel = aForward*X + aStrafe*Y; 
		NewAccel.x=0;
		NewAccel.y=0;
		NewAccel.Z = 0;
		// Check for Dodge move
		
		AnimGroupName = GetAnimGroup(AnimSequence);		
		if ( (Physics == PHYS_Walking) )
		{
			Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);
		}

		// Update rotation.
		//OldRotation = Rotation; //not needed -AdamJD
		//UpdateRotation(DeltaTime, 1); //not needed -AdamJD


		ProcessMove(DeltaTime, NewAccel, DodgeMove, OldRotation - Rotation);
	
	}

	function BeginState()
	{
		DebugState();
		if ( Mesh == None )
			SetMesh();
		WalkBob = vect(0,0,0);
		DodgeDir = DODGE_None;
		bIsCrouching = false;
		bIsTurning = false;
		bPressedJump = false;
		if (Physics != PHYS_Falling) SetPhysics(PHYS_Walking);
		if ( !IsAnimating() )
			PlayWaiting();
	}
	
	function EndState()
	{
		WalkBob = vect(0,0,0);
		bIsCrouching = false;
	}
}




/*----------------------------------------------------------------------------

this override of PlayerCalcView allows the use of a third person camera

-------------------------------------------------------------------------------*/

event PlayerCalcView(out actor ViewActor, out vector CameraLocation, out rotator CameraRotation )
{
	local Pawn PTarget;

	if ( ViewTarget != None )
	{
		ViewActor = ViewTarget;
		CameraLocation = ViewTarget.Location;
		CameraRotation = ViewTarget.Rotation;
	}

}

function rotator AdjustAim(float projSpeed, vector projStart, int aimerror, bool bLeadTarget, bool bWarnTarget)
{
	local vector FireDir;
	local actor BestTarget;
	local actor HitActor;
	local rotator defaultAngle,checkAngle;
	local pawn hitPawn;
	local vector objectDir;
	local int bestYaw;
	local int tempYaw, defaultYaw;
	local float bestZ;

	defaultAngle = Rotation;
	defaultAngle.pitch=0;
	defaultYaw = defaultAngle.yaw;
	defaultYaw = defaultYaw & 0xffff;

	fireDir = vector(defaultAngle);
	fireDir = normal(fireDir);
	bestTarget = none;

	//if (rectarget.victim == none) //not needed -AdamJD
	//{
		foreach VisibleActors( class 'ACTOR', hitactor)
		{
			if( HitActor.bprojtarget && PlayerPawn(HitActor) != Self && !HitActor.IsA('BaseCam'))
			{
			
				objectdir=normal(hitactor.location-projstart);
				//fireDir.z=objectdir.z;
				checkAngle=rotator(objectdir);

				if(bestTarget==none)
				{
					bestYaw = checkAngle.yaw;
					bestYaw = bestYaw & 0xffff;
					bestTarget = hitactor;
					bestZ = objectdir.z;
				}
				else
				{	
					tempYaw = checkangle.yaw;
					tempYaw = tempYaw & 0xffff;
					if( abs(tempYaw - defaultYaw) < abs(bestYaw - defaultYaw))
					{
						bestYaw = tempYaw;
						bestTarget = hitActor;
						bestZ = objectdir.z;
					}
				}
			}
			
		}
	//}
	//not needed -AdamJD
	/*
	else
	{
		bestTarget = rectarget.victim;
		objectdir = normal(rectarget.victim.location - projstart);
		checkAngle = rotator(objectdir);
		bestYaw = checkAngle.yaw;
		bestYaw = bestYaw & 0xffff;
		bestZ = objectdir.z;
	}
	*/

	if(bestTarget != none)
	{
	
		//tempYaw=defaultAngle.yaw;
		//tempYaw=tempYaw&0xffff;


		if(abs(bestYaw - defaultYaw) < 8000)
		{
			fireDir.z=bestZ;
		}
	}
	defaultAngle = rotator(fireDir);

	return defaultAngle;
}

function timer()
{

}

function DialogResponse(int dialogNum)
{
		local sound step;
		step=speech[dialogNum];
		PlaySound(step, SLOT_Talk,1.0, false, 1000.0, 0.9);
}

function nailed(actor caller,out int status)
{

	if(bustedby==none)
	{
		bustedby=caller;
		status=1;
		gotostate('waitfordeath');
	}
	else
	{
		status=0;
	}
	
}


function displaydemoMessage()
{

	basehud(myHud).ShowPopup(class'demoLetter');
}


state waitForDeath
{

	begin:
		DebugState();


	loop:
		if(abs(vsize(location-bustedby.location))<150)
		{
			moveto(location);
			playAnim('look');
		}
		else
		{
			moveToward(bustedby);
			loopAnim('run');
		}

	
		
		

	//	sleep (0.3);
		goto 'loop';

}

function makeTarget()
{
	local vector tloc;
	local vector targetoffset;

	targetOffset.x=50;
	targetOffset.y=0;
	targetOffset.z=0;

	tloc=targetOffset>>viewrotation;
	tloc +=location;
	
	rectarget=spawn(class'target',,,tloc);
	
	//not needed -AdamJD
	/*
	if(rectarget==none)
	{
		targetOffset.y=0;
		targetOffset.x=50;
		targetOffset.z=0;

		tloc=targetOffset>>viewrotation;
		tloc +=location;

		rectarget=spawn(class'target',,,tloc);
	}
	*/
	
	if(rectarget==none)
	{
		gotostate('playerwalking');
		clientmessage("failed targetspawn");
		hpconsole(player.console).bspaceReleased=true;
		hpconsole(player.console).bSpacePressed=false;
	}
	
	else
	{
		// rectarget.p=self;
		rectarget.targetOffset.x=100;
		rectarget.targetOffset.y=0;
		rectarget.targetOffset.z=0;
	}
}

//now not needed -AdamJD
/*
// @PAB added new camera target
function makeCamTarget()
{
	local vector tloc;
	local vector targetoffset;

	//not needed -AdamJD
	// targetOffset.y=0; 
	// targetOffset.x=50; 
	// targetOffset.z=0; 
	
	StandardTarget=spawn(class'camtarget',,,tloc);*/
	// tloc=targetOffset>>viewrotation; //not needed -AdamJD
	// tloc+=location; //not needed -AdamJD
	
	//not needed -AdamJD
	/*
	if(StandardTarget==none)
	{
		targetOffset.y=0;
		targetOffset.x=50;
		targetOffset.z=0;

		tloc=targetOffset>>viewrotation;
		tloc=tloc+location;

		StandardTarget=spawn(class'camtarget',,,tloc);
	}
	if(StandardTarget==none)
	{
		gotostate('playerwalking');
		hpconsole(player.console).bspaceReleased = true;
		hpconsole(player.console).bSpacePressed = false;
	}
	*/
	
	/*
	 StandardTarget.p=self; 
	// StandardTarget.targetOffset.y=0; /not needed -AdamJD
	// StandardTarget.targetOffset.x=100; /not needed -AdamJD
	 StandardTarget.targetOffset.x= SmoothMouseX; //AdamJD
	 StandardTarget.targetOffset.y= SmoothMouseY; //AdamJD
	 StandardTarget.targetOffset.z=0;
	//StandardTarget.gotostate('seeking'); /not needed -AdamJD
}*/

state SpellLearning
{
	// Harry be motionless here.
	ignores ProcessMove, AltFire;
}

defaultproperties
{
	ShadowClass=Class'HarryPotter.HarryShadow'
    eaid(0)="xEU-0000004821-SD-001753aabac325f07cb3fa231144fe2e33ae4783feead2b8a73ff021fac326df0ef9753ab9cdf6573ddff0312fab0b0ff39779eaff312x"
    HurtSound(0)=Sound'HPSounds.Har_Emotes.ouch1'
    HurtSound(1)=Sound'HPSounds.Har_Emotes.ouch2'
    HurtSound(2)=Sound'HPSounds.Har_Emotes.ouch3'
    HurtSound(3)=Sound'HPSounds.Har_Emotes.ouch4'
    HurtSound(4)=Sound'HPSounds.Har_Emotes.ouch5'
    HurtSound(5)=Sound'HPSounds.Har_Emotes.ouch6'
    HurtSound(6)=Sound'HPSounds.Har_Emotes.ouch7'
    HurtSound(7)=Sound'HPSounds.Har_Emotes.ouch8'
    HurtSound(8)=Sound'HPSounds.Har_Emotes.ouch9'
    HurtSound(9)=Sound'HPSounds.Har_Emotes.ouch10'
    HurtSound(10)=Sound'HPSounds.Har_Emotes.ouch11'
    HurtSound(11)=Sound'HPSounds.Har_Emotes.ouch12'
    HurtSound(12)=Sound'HPSounds.Har_Emotes.ouch13'
    HurtSound(13)=Sound'HPSounds.Har_Emotes.oof1'
    HurtSound(14)=Sound'HPSounds.Har_Emotes.oof2'
    GroundSpeed=200
    AirSpeed=400
    AccelRate=1024
    JumpZ=245
    MaxMountHeight=96.5
    AirControl=0.25
    BaseEyeHeight=40.75
    EyeHeight=40.75
    MenuName="Harry"
    DrawType=DT_Mesh
    Mesh=SkeletalMesh'HarryPotter.skharryMesh'
    CollisionRadius=15
    CollisionHeight=42
    Mass=1
    Buoyancy=118.8
	RotationRate=(Pitch=20000,Yaw=70000,Roll=3072) 	//added the rotation rate in the default props -AdamJD
}