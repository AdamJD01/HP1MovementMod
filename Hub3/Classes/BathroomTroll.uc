class BathroomTroll expands BaseTroll;

//Edited by- AdamJD (edited code will have AdamJD by it)

var float				TimeRemaining;
var	BaseToiletObject	ThrownObject;

//var baseharry	Player;
var BathroomRon	CastingRon;

var bool		bThrowing;
var bool        bPlayedPickedUpObjectSound;
var bool        bPlayedFirstThrowSound;

var bool        bLastAnimWasRoar;

var vector      vThrowObjectOffset;

var int         iCurrentObject;
var bool		bKnockedOut;
var	float		ThrowRate;

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
{
}

auto state Initial
{
	function beginstate()
	{

		// foreach AllActors(class'baseharry', playerHarry)
		// {
			// break;
		// }

		foreach AllActors(class'BathroomRon', CastingRon)
		{
			break;
		}

		//Temp set up for this test
//		basewand(playerHarry.weapon).addspell(class'spellflip');
		playerHarry.bosstarget = self;
		//playerHarry.cam.gotostate('bossstate');

		loopanim('breathe');
//		gotostate('combat');
	}
}

state Combat
{
	// Throw objects

	function beginstate()
	{
		TimeRemaining = 4;
		bThrowing = false;
	}

	function animend()
	{
/*		if (animsequence == 'swing')
		{
			loopanim('breath');
		}
*/
			if( !bLastAnimWasRoar  &&  rand(4) == 0 && ThrowRate < 1.5)
			{
				bLastAnimWasRoar = true;
				//just roar
				playanim('roar', 1.5);

				switch( Rand(3) )
				{
					case 0: PlaySound( Sound'HPSounds.critters_sfx.troll_roar1', SLOT_None); break;
					case 1: PlaySound( Sound'HPSounds.critters_sfx.troll_roar2', SLOT_None); break;
					case 2: PlaySound( Sound'HPSounds.critters_sfx.troll_roar3', SLOT_None); break;
				}
			}
			else
			{
				bLastAnimWasRoar = false;

				playanim('throw', ThrowRate );
				bPlayedFirstThrowSound = false;
				bPlayedPickedUpObjectSound = false;
				bThrowing = true;

				vThrowObjectOffset = vect(0,0,0);

				switch( iCurrentObject )//Rand(5) )
				{
					case 0:
						ThrownObject = spawn(class'TrollThrowPipe', self, [spawnlocation] WeaponLoc);
						vThrowObjectOffset = vect(0,0,0);
						break;
					case 1:
						ThrownObject = spawn(class'TrollThrowToilet', self, [spawnlocation] WeaponLoc);
						vThrowObjectOffset = vect(0,0,-10);
						break;
					case 2:
						ThrownObject = spawn(class'TrollThrowSink', self, [spawnlocation] WeaponLoc);
						vThrowObjectOffset = vect(0,0,-20);
						break;
					case 3:
						ThrownObject = spawn(class'TrollThrowStone', self, [spawnlocation] WeaponLoc);
						vThrowObjectOffset = vect(0,0,10);
						break;
					case 4:
						ThrownObject = spawn(class'TrollThrowWood', self, [spawnlocation] WeaponLoc);
						break;
				}

				iCurrentObject = (iCurrentObject+1) % 5;

				//Fuck it!
				//ThrownObject.AttachToOwner('MTroll R Hand');//'RightHand');

				BaseHUD(playerHarry.MyHUD).DebugValX = WeaponLoc.x;
				BaseHUD(playerHarry.MyHUD).DebugValY = WeaponLoc.y;
				BaseHUD(playerHarry.MyHUD).DebugValZ = WeaponLoc.z;

			}
//				TimeRemaining = 4;
	}

	function tick(float deltatime)
	{
		local vector v;

/*		TimeRemaining -= deltatime;

		if (TimeRemaining < 0)
		{
		}
*/
		if (animsequence == 'throw')
		{
			if( !bPlayedPickedUpObjectSound && animframe > 0.075 )
			{
				bPlayedPickedUpObjectSound = true;

				//switch( Rand(2) )
				//{
					/*case 0:*/ PlaySound( Sound'HPSounds.critters_sfx.troll_grabs_object1', SLOT_None, [Volume]RandRange(0.5, 0.6), [Radius]100000, [Pitch]RandRange(0.7, 1.2) ); //break;
				//	case 1: PlaySound( Sound'HPSounds.critters_sfx.troll_grabs_object2', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.7, 1.2) ); break;
				//}
			}

			if( !bPlayedFirstThrowSound && animframe > 0.525 )
			{
				bPlayedFirstThrowSound = true;
				PlaySound(sound'HPSounds.Hub5_sfx.whoosh2', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.9, 1.1) ); //break;
			}

			if (animframe > 0.6 && bThrowing)
			{
				//casting at objects thrown at Ron is bugged for the new Harry code so I've made all the objects go towards Harry -AdamJD
				// if( FRand() < 0.8 )
					ThrownObject.ThrowObject(playerHarry);
				// else
					// ThrownObject.ThrowObject(CastingRon);

//				PlaySound(sound'HPSounds.Hub1_sfx.peeves_Throws', SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.9, 1.1) ); //break;
				switch( Rand(3) )
				{
					case 0: PlaySound( Sound'HPSounds.critters_sfx.troll_attack1', SLOT_None); break;
					case 1: PlaySound( Sound'HPSounds.critters_sfx.troll_attack2', SLOT_None); break;
					case 2: PlaySound( Sound'HPSounds.critters_sfx.troll_attack3', SLOT_None); break;
				}

				ThrownObject.GotoState('FlyingState');
				bThrowing = false;
			}
		}

		if( bThrowing )
		{
			//v = vect(0,0,30);
			v = vThrowObjectOffset >> WeaponRot;
			//v = vect(0,0,0);
			//ThrownObject.SetLocation( WeaponLoc - v);
			ThrownObject.Move( (WeaponLoc+v) - ThrownObject.Location );
			ThrownObject.SetRotation( WeaponRot );
			//Log("*********** wl:"$WeaponLoc$" ol:"$ThrownObject.Location);
		}
		//playerHarry.ClientMessage("wl:"$WeaponLoc$" wr:"$WeaponRot);//ThrownObject.AnimBone:" $ ThrownObject.AnimBone $ "  Owner:"$ThrownObject.Owner$"  phys:"$ThrownObject.physics$" bStatic:"$ThrownObject.bStatic$" bMovable:"$bMovable);

	}
}

state Concussed
{
	// Troll falls and battle ends
	function beginstate()
	{
		local rotator	lrot;

		lrot = Rotation;
		lrot.yaw -= 0x1fff;
		DesiredRotation = lrot;

		PlaySound( Sound'HPSounds.hub3_sfx.troll_club_hit', SLOT_None, [Radius]100000, [Pitch]RandRange(0.7, 1.2) );
		PlaySound( Sound'HPSounds.hub3_sfx.troll_defeated', SLOT_talk, [Radius]100000, [Pitch]RandRange(0.7, 1.2) );
		PlayAnim('knockout');
		ThrownObject.Destroy();
		bKnockedOut = false;
	}

	function tick(float fDeltaTime)
	{
		local actor A;

		if (AnimSequence == 'knockout')
		{
			if (animframe > 0.70 && !bKnockedOut)
			{
				PlaySound(sound'HPSounds.hub5_sfx.Vold_bridge_collapse2');
//				playerHarry.cam.ShakeCamera(2, 60);
				// Trigger the end scene
				if( Event != '' )
				{
					foreach AllActors( class 'Actor', A, Event )
					{
						A.Trigger( self, self );
					}
				}
				bKnockedOut = true;
			}
		}
	}

	function AnimEnd()
	{
		if (AnimSequence == 'knockout')
		{
//			PlaySound(sound'HPSounds.hub3_sfx.troll_fall');
			// @PAB this is sound is more apprpriate
			loopanim('Knockedout');

		}
	}
}

defaultproperties
{
     ThrowRate=1
     bCollideActors=False
}
