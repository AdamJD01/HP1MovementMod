//=============================================================================
// baseWand
//=============================================================================
class baseWand extends Weapon;
#exec MESH  MODELIMPORT MESH=WandMesh MODELFILE=models\Wand.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WandMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WandAnims ANIMFILE=models\Wand.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WandMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WandMesh ANIM=WandAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WandAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WandTex0  FILE=TEXTURES\WandTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WandMesh NUM=0 TEXTURE=WandTex0




var() int HitDamage;
var Pickup Amp;
var bool bBotSpecialMove;

var bool bAutoSelectSpell;
var bool bUseNoSpell;

var class<baseSpell> curSpell;

//hard coded number of spells?
var class<baseSpell> spellList[16];

var particleFX wandEffect;
var baseProps testWand;

var float maxMana;
var float curMana;
var bool bUseMana;
var bool bCasting;

// ref to a spell that harry is "holding" (actually hidden), so if he hits throw, the one "in his hand" can be destroyed.
//  if this matches the type of spell harry's about to cast, destroy.
var baseSpell DestroyThisOnCast;

var baseSpell LastCastedSpell;


event Tick(float deltaTime)
{
local vector v;
local rotator r;

	super.tick(deltaTime);
	if(bUseMana)
		{
		curMana+=deltaTime*5;
		if(curMana>maxMana)
			curMana=maxMana;
		}

	/*
	if(wandEffect!=None && pawn(owner) != none && pawn(owner).Weapon==self)
		{
		r=pawn(owner).weaponRot;
		v=vect(0,0,20);
		v=v>>r;
		wandEffect.setLocation(pawn(owner).weaponLoc - v);
		if(bCasting)
			wandEffect.ParticlesPerSec.Base=wandEffect.default.ParticlesPerSec.Base;
		else
			wandEffect.ParticlesPerSec.Base=4.1;
		}*/
}

function BecomeItem()
{
	//Inventory::BecomeItem sets bHidden to true.
	Super.BecomeItem();

	bHidden = false;
}

function addSpell(class<baseSpell> spell)
{
local int i;
	for(i=0;i<16;i++)
		{
		if(spellList[i]==spell)
			return;
		if(spellList[i]==None)
			{
			spellList[i]=spell;
			curSpell=spellList[i];
				//play sound
			return;
			}
		}
}

event BeginPlay()
{

	/*
	if(wandEffect==None)
		{
		wandEffect=Spawn(class'Levitate_wand',,, location,rot(0,0,0));
		wandEffect.ParticlesPerSec.Base=0;
		wandEffect.bVelocityRelative=false;
		}
		*/

	bUseNoSpell = true;
}

event Destroyed()
{
	if( wandEffect != none )
		wandEffect.Destroy();
	super.Destroyed();
}

exec function AllSpells()
{
	addSpell(Class'spellAloho');
	addSpell(Class'spellAvif');
	addSpell(Class'spellFlint');
	addSpell(Class'spellVerd');
	addSpell(Class'spellLev');

	addSpell(Class'spellflip');
}

function SelectSpell(class<baseSpell> spell)
{
	curSpell=spell;
}



function ChooseSpell(ESpellType Spell)
{
	switch(Spell)
	{

		case SPELL_None:
			if (bUseNoSpell)
			{
				SelectSpell(class'spellnone');
			}
			break;
		case SPELL_Alohomora:
			SelectSpell(class'spellAloho');
			break;
		case SPELL_Incendio:
			SelectSpell(class'spellIncendio');
			break;
		case SPELL_LocomotorWibbly:
			SelectSpell(class'spellAloho');
			break;
		case SPELL_Lumos:
			SelectSpell(class'spelllumas');
			break;
		case SPELL_Nox:
			SelectSpell(class'spellAloho');
			break;
		case SPELL_PetrificusTotalus:
			SelectSpell(class'spellAloho');
			break;
		case SPELL_WingardiumLeviosa:
			SelectSpell(class'spellLev');
			break;
		case SPELL_WingSustain:
			SelectSpell(class'spellPostLev');
			break;

		case SPELL_Verdimillious:
			SelectSpell(class'spellVerd');
			break;
		case SPELL_Vermillious:
			SelectSpell(class'spellAloho');
			break;
		case SPELL_Flintifores:
			SelectSpell(class'spellFlint');
			break;
		case SPELL_Reparo:
			SelectSpell(class'spellRepairo');
			break;
		case SPELL_MucorAdNauseum:
			SelectSpell(class'spellAloho');
			break;
		case SPELL_Flipendo:
			SelectSpell(class'spellFlip');
			break;
		case SPELL_Ectomatic:
			SelectSpell(class'spellEcto');
			break;
		case SPELL_Avifores:
			SelectSpell(class'spellAvif');
			break;
		case SPELL_FireCracker:
			SelectSpell(class'spellFireCracker');
			break;
	}
}

function forcespell(actor target)
{
	LastCastedSpell = baseSpell( ProjectileFire(curSpell, AltProjectileSpeed, false) );
	LastCastedSpell.target = target;
}

function CastSpell(Actor target)
{
	local actor		HitActor;
	local vector	HitLocation, HitNormal, Start; 
	local sound		outSound;
	local string	Label, outText, Language;

	bPointing=True;//whats this for??

	// Enable this for the PS1 Conversion O' Joy
	if(bAutoSelectSpell)
	{
		
		log ("Attempting to Cast a Spell");
		log("The Target is " $ target);
		log("It is Vunerable to " $target.eVulnerableToSpell);

		if(target!=None)
		{
			ChooseSpell(target.eVulnerableToSpell);
		}
	}

	log("CurSpell = " $curSpell);
	if(curSpell==None)
		return;

	// say the magic word.....

	//AE: Moved incantation to after 'LastCastedSpell' is set, because it's used.

	if(bUseMana)
	{
		if(curMana>=curSpell.default.manaCost)
				curMana-=curSpell.default.manaCost;
		else
			return;
	}

	LastCastedSpell=baseSpell( ProjectileFire(curSpell, AltProjectileSpeed, false) );
	LastCastedSpell.target = target;
	LastCastedSpell.OriginallyCastedBy = baseChar(Owner);

	// AE:
	Language = caps(baseHarry(PlayerPawn(Owner)).theNarrator.GetLanguage());
	if( Owner.IsA('BaseHarry') && (Language == "INT" || Language == "ENG") )
	{
		// Owner is Harry and it's english localised.
		LastCastedSpell.PlayIncantateSound( baseHarry(PlayerPawn(Owner)).bInSneak );
	}
	else
	{
		if (baseHarry(PlayerPawn(Owner)).bInSneak)
		{
			Label = CurSpell.default.QuietSpellIncantation;
		}
		else
		{
			Label = CurSpell.default.SpellIncantation;
		}

		if (Label != "")
		{
			baseHarry(PlayerPawn(Owner)).theNarrator.FindDialog(Label, outSound, outText);
			if (outSound != none)
			{
				PlayerPawn(Owner).PlaySound(outSound, SLOT_Talk);
			}
		}
	}

	//See if there's a matching object we should get rid of.  Also set curSpell to none.
	if( DestroyThisOnCast != none) //!= none  &&  curSpell(DestroyThisOnCast) != none )
	{
		DestroyThisOnCast.Destroy();
		SelectSpell(none);
	}

	//	Owner.PlaySound(AltFireSound, SLOT_None,Pawn(Owner).SoundDampening*4.0);

	//REVISIT this is causeing a noanim in the log.	
	//REVISIT PlayAnim('all',0.8,0.05);
	//REVISIT ................................

}

function Texture GetSpellIcon()
{
	if(curSpell!=None)
		return curSpell.Default.spellIcon;
	else
		return None;
}

function inventory SpawnCopy( pawn Other )
{
	local inventory Copy;
	local Inventory I;

	Copy = Super.SpawnCopy(Other);

	return Copy;
}


function AltFire( float Value )
{
	local actor HitActor;
	local vector HitLocation, HitNormal, Start; 


	if ( PlayerPawn(Owner) != None )
		{
		PlayerPawn(Owner).ClientInstantFlash( -0.4, vect(0, 0, 800));
		PlayerPawn(Owner).ShakeView(ShakeTime, ShakeMag, ShakeVert);
		}
	bPointing=True;
	ProjectileFire(AltProjectileClass, AltProjectileSpeed, bAltWarnTarget);

	Owner.PlaySound(AltFireSound, SLOT_None,Pawn(Owner).SoundDampening*4.0);
	PlayAnim('all',0.8,0.05);

	if ( Owner.bHidden )
		CheckVisibility();
}



function float RateSelf( out int bUseAltMode )
{
	return 99.0;	//wand is always the best weapon. well, its the _only_ weapon. 
}

function BecomePickup()
{
	Amp = None;
	Super.BecomePickup();
}

function Timer()
{
	local actor targ;
	local float bestAim, bestDist;
	local vector FireDir;

	bestAim = 0.95;
	if ( Pawn(Owner) == None )
	{
		GotoState('');
		return;
	}
	FireDir = vector(Pawn(Owner).ViewRotation);
	targ = Pawn(Owner).PickTarget(bestAim, bestDist, FireDir, Owner.Location);
	if ( Pawn(targ) != None )
	{
		bPointing = true;
		Pawn(targ).WarnTarget(Pawn(Owner), 300, FireDir);
		SetTimer(1 + 4 * FRand(), false);
	}
	else 
	{
		SetTimer(0.5 + 2 * FRand(), false);
		bPointing = false;
	}
}	

function Finish()
{
	if ( (Pawn(Owner).bFire!=0) && (FRand() < 0.6) )
		Timer();

	Super.Finish();
}

///////////////////////////////////////////////////////
function PlayFiring()
{
	//Owner.PlaySound(FireSound, SLOT_None, Pawn(Owner).SoundDampening*4.0);
	
	PlayAnim('all', 0.5,0.05);
}

function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Vector Start, X,Y,Z;

	Owner.MakeNoise(Pawn(Owner).SoundDampening);

//Log("Projectile fire owner:" $owner $" Rotation:" $Pawn(owner).ViewRotation);
	
	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start = Owner.Location + CalcDrawOffset() + FireOffset.X * X + FireOffset.Y * Y + FireOffset.Z * Z; 
	bSplashDamage = false;

	if(ProjClass==Class'spellEcto')
		AdjustedAim = pawn(owner).AdjustToss(ProjSpeed, Start, 0, True, (bWarn || (FRand() < 0.4)));	
	else
		AdjustedAim = pawn(owner).AdjustAim(ProjSpeed, Start, AimError, True, bWarn);	
	bSplashDamage = true;
	return(Spawn(ProjClass,,, Start,AdjustedAim));

}



function SpawnEffect(Vector DVector, int NumPoints, rotator SmokeRotation, vector SmokeLocation)
{
//cmp cleanup	local RingExplosion4 Smoke;
	
//cmp cleanup	Smoke = Spawn(class'RingExplosion4',,,SmokeLocation,SmokeRotation);
//cmp cleanup	Smoke.MoveAmount = DVector/NumPoints;
//cmp cleanup	Smoke.NumPuffs = NumPoints;
}


function PlayIdleAnim()
{
}

state Idle
{

	function BeginState()
	{
		bPointing = false;
		SetTimer(0.5 + 2 * FRand(), false);
		Super.BeginState();
		if (Pawn(Owner).bFire!=0) Fire(0.0);
		if (Pawn(Owner).bAltFire!=0) AltFire(0.0);		
	}

	function EndState()
	{
		SetTimer(0.0, false);
		Super.EndState();
	}

}

defaultproperties
{
     HitDamage=35
     bAutoSelectSpell=True
     maxMana=100
     curMana=50
     PickupAmmoCount=200
     bSplashDamage=True
     FireOffset=(Y=-6,Z=-7)
     AltProjectileClass=Class'HPBase.baseSpell'
     AimError=0
     AltRefireRate=0.7
     DeathMessage="%k inflicted mortal damage upon %o with the %w."
     AutoSwitchPriority=4
     InventoryGroup=4
     PickupMessage="You got the ASMD"
     ItemName="Wand"
     PlayerViewOffset=(X=3.5,Y=-1.8,Z=-2)
     ThirdPersonMesh=SkeletalMesh'HPBase.WandMesh'
     Mesh=SkeletalMesh'HPBase.WandMesh'
     bNoSmooth=False
     CollisionRadius=28
     CollisionHeight=8
     Mass=50
}
