class BathroomRon extends baseChar;

var BathroomClub	Club;
var BaseHarry		Player;
var Hermione		Hermy;
var BathroomTroll	Troll;

function PostBeginPlay()
{
	local float			fDistance;
	local BathroomTroll	ClosestTroll;
	local weapon        weap;

	// Find club
	foreach AllActors(class'BathroomClub', Club)
	{
		break;
	}

	foreach AllActors(class'BaseHarry', Player)
	{
		break;
	}

	foreach AllActors(class'Hermione', Hermy)
	{
		break;
	}

	fDistance = 99999999;

	foreach AllActors(class'BathroomTroll', Troll)
	{
		if (vsize(Club.location - Troll.location) < fDistance)
		{
			fDistance = vsize(Club.location - Troll.location);
			ClosestTroll = Troll;
		}
	}

	log("Troll found " $string(ClosestTroll.name));
	Troll = ClosestTroll;
	Club.ClubTarget = Troll;

	Super.PostBeginPlay();

	weap=spawn(class'baseWand');
	weap.BecomeItem();
	AddInventory(weap);
	weap.WeaponSet(self);
	weap.GiveAmmo(self);
	baseWand(weap).bUseMana=false;
	log(self$ " spawning weap " $weap);
}

// This trigger is called to start off the battle sequence

function Trigger(actor Other, pawn EventInstigator)
{
	basewand(player.weapon).bUseNoSpell = false;

	Hermy.gotostate('idle');
	Troll.gotostate('combat');
	log("Troll called, " $string(troll.name));
	Club.gotostate('Levitating');
	Player.StopBossEncounter();
	Player.cam.bUseBattleCam = true;
}

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
{
	// we need to move the club back here
//	log("Ron has been damaged");

	GotoState('stateHurt');

	Club.MoveBackwards();
}

function touch(actor other)
{
	log("Ron has been touched");

	//Club.MoveBackwards();
}

auto state idle
{
begin:
	loopanim('breathe');
}

state casting
{
	function AnimEnd()
	{
		if (animsequence == 'cast')
		{
			loopanim('levitate');
		}
	}

	function BeginState()
	{
		local string	Text;
		local sound		dlgSound;

		player.theNarrator.FindDialog("ron_new_21", dlgSound, text);
		if (dlgSound!=None)
		{
			PlaySound(dlgSound, SLOT_Talk);
		}

		playanim('cast');
	}

begin:
	turntoward(Club);

}

//**********************************************************************************************************
state stateHurt
{
  Begin:
	PlayAnim('land1', 1.0, 0.15);
	PlayHurtSound();
	FinishAnim();
	GotoState('casting');
}

//**********************************************************************************************************
function PlayHurtSound()
{
	local sound snd;

	FindEmote("EmotiveRon3", snd);

	PlaySound( snd, SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.7, 1.2) ); //break;
}

//**********************************************************************************************************
state EndCast
{
	ignores TakeDamage;

begin:
	playanim('release');
	finishanim();
	loopanim('breathe');
}

defaultproperties
{
     GroundSpeed=230
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skronMesh'
     CollisionHeight=40
}
