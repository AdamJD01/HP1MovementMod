//===============================================================================
//  [Column] 
//===============================================================================

class Column extends HProps;

// Vars ...

var(Column) int   _NumShards;
var(Column) float fFallAnimRate;


// Code ...

event Trigger( Actor Other, Pawn EventInstigator )
{
	local vector   v;
	local rotator  r;

	v = Location;
	v.z += -collisionHeight + collisionRadius;
	r = rotator( vect(0,0,1) );

	Disintegrate(v, r);
}

auto state Stationary
{
	function bool TakeSpellEffect(baseSpell spell)
	{
		if( spellVoldemortStraight(spell) != None)
		{
			//Let harry know a column just got wobbled
			harry(playerHarry).VoldColumnGotWobbled();
			gotostate ('Wobbling');
		}
	}
}

function Disintegrate (vector start_locn, rotator dirn)
{
	local int          i;
	local vector       vectGap;
	local ColumnShard  a;

	vectGap.z = CollisionHeight*2/_NumShards;
	vectGap = vectGap >> dirn;

	start_locn += (vectGap/2);

	for (i=0; i<_NumShards; ++i)
	{
		//log ("column shard, start_locn " $start_locn);
		a = spawn(class'ColumnShard',,,start_locn,RotRand ());
		if( i == 0 )
			a.PlaySoundTimer = RandRange( 0.75, 1.3333 );

		Spawn(class'SmokeExplo_01',,, start_locn,rot(0,0,0));

		start_locn += vectGap;
	}

	DestroyColumn();
}

//********************************************************************
//Derived class overrides.  Could make a Destroy() function in my derived class
function DestroyColumn()
{
	PlaySound(sound'HPsounds.Hub5_sfx.voldemorts_pillars_explode',
		[Radius]100000, [Pitch]RandRange(0.9, 1.1) );

	Destroy();
}

//********************************************************************
state Wobbling
{
	function beginState()
	{
		switch( Rand(6) )
		{
		case 0: PlaySound(
		sound'HPSounds.Hub5_sfx.Vold_Pillar_Thump_01' ); break;
		case 1: PlaySound(
		sound'HPSounds.Hub5_sfx.Vold_Pillar_Thump_02' ); break;
		case 2: PlaySound(
		sound'HPSounds.Hub5_sfx.Vold_Pillar_Thump_03' ); break;
		case 3: PlaySound(
		sound'HPSounds.Hub5_sfx.Vold_Pillar_Thump_04' ); break;
		case 4: PlaySound(
		sound'HPSounds.Hub5_sfx.Vold_Pillar_Thump_05' ); break;
		case 5: PlaySound(
		sound'HPSounds.Hub5_sfx.Vold_Pillar_Thump_06' ); break;
		}

		PlayAnim('teeter', 0.5);
	}

	function bool TakeSpellEffect(baseSpell spell)
	{
		local vector start_locn;
		local bool bIsVoldemortSpell;

		// Detect if the spell was from Voldemort

		if (spellVoldemortStraight(spell) != None)
			bIsVoldemortSpell = true;

		if (spellVoldemortTracking(spell) != None)
			bIsVoldemortSpell = true;

		if (bIsVoldemortSpell)
		{
			// If Voldemort shot the pillar, then blow it up

			//start_locn = location;
			//start_locn.z -= collisionHeight;
			//
			//Disintegrate (start_locn, rotation);
		}
		else
		{
			// otherwise topple it

			eVulnerableToSpell = SPELL_None;
			gotostate ('isFalling');
		}
	}

	function Tick(float DeltaTime)
	{
		if (!IsAnimating())
			gotostate('Stationary');
	}

  Begin:
//	PlaySound( sound'HPSounds.Hub5_sfx.vold_column_wobble_2', SLOT_none, [Pitch]RandRange(0.9, 1.1) );
	Sleep(1.25);
//	PlaySound( sound'HPSounds.Hub5_sfx.vold_column_wobble_1', SLOT_none, [Pitch]RandRange(0.9, 1.1) );

}

state isFalling
{
	function beginState()
	{
		PlayAnim('fall', fFallAnimRate, 1);
		SetTimer( 0.4/fFallAnimRate, false );

		PlaySound( sound'HPSounds.critters_sfx.norbert_puff', [Radius]100000, [Pitch]RandRange(0.9, 1.1) );
	}

	event Timer()
	{
		local rotator      r;
		local vector       v, v2;
		local BossQuirrel  a;

		//local baseHarry b;

		ForEach AllActors(class'BossQuirrel', a)
			break;

		if( a == none )
			return;

		r = rotation;
		r.yaw += 16384;  // <-- as expected, the artist didn't animate down the x axis.
		v = vector(r);

		//ForEach AllActors(class'baseHarry', b)
		//	break;

		v2 = a.Location - Location;
		v2.z = 0;

		//b.clientMessage("vsize2d:" @ VSize2d(v2));
		//b.clientMessage("dot:" @ (normal(v2) dot v));

		if(   VSize(v2)          < 250            //close?
		   && (normal(v2) dot v) > 0.966 //cos(15) //within n degrees of the column falling?
		  )
		{
			//Make the column blow up.  Jonathan, not sure if you want to do this differently...
			AnimEnd();

			//Tell vold to do his anim
			a.HandleHitByColumn();
		}

	}

	function AnimEnd ()
	{
		local vector start_locn;
		local rotator fall_dirn;
		local vector vectBaseRadius;

		// rotate direction

		fall_dirn = rotation;
		fall_dirn.pitch += 16384;
		fall_dirn.yaw -= 16384;

		// move start location to bottom of pillar

		start_locn = location;
		start_locn.z -= collisionHeight;

		// up and along a bit to allow for falling over

		start_locn.z += collisionRadius;

		vectBaseRadius.z = collisionRadius;
		vectBaseRadius = vectBaseRadius >> fall_dirn;

		start_locn += vectBaseRadius;

		Disintegrate (start_locn, fall_dirn);
	}
}

defaultproperties
{
     _NumShards=13
     fFallAnimRate=0.5
     bStatic=False
     eVulnerableToSpell=SPELL_Flipendo
     bDirectional=True
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.voldmortchallengepillarMesh'
     CollisionRadius=46
     CollisionHeight=128
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bProjTarget=True
}
