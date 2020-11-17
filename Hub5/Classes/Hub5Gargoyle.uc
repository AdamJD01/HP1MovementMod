//===============================================================================

class Hub5Gargoyle extends voldChallengeWholeGargoyle;

var() int   NumShards;

var   int   CurrentLife;

//********************************************************************************
function Trigger( actor Other, pawn EventInstigator )
{
}

//********************************************************************************
function Disintegrate (vector start_locn, rotator dirn)
{
	local int i;
	local vector vectGap;

	vectGap.z = CollisionHeight*2/NumShards;
	vectGap = vectGap >> dirn;

	start_locn += (vectGap/2);

	for (i=0; i<Numshards; ++i)
	{
		//log ("column shard, start_locn " $start_locn);
		spawn(class'ColumnShard',,,start_locn,RotRand ());

		Spawn(class'SmokeExplo_01',,, start_locn,rot(0,0,0));

		start_locn += vectGap;
	}

	if( FRand() < 0.5 )
		PlaySound( sound'HPSounds.hub5_sfx.norbert_egg_hatching', Slot_none, [Volume]0.6, [Radius]100000, [Pitch]RandRange(0.9, 1.1) );

	if( FRand() > 0.5 )
		PlaySound( sound'HPSounds.hub5_sfx.rock_breaking', Slot_none, [Radius]100000, [Pitch]RandRange(0.9, 1.1) );
	else
		PlaySound( sound'HPSounds.hub5_sfx.troll_smasher', Slot_none, [Radius]100000, [Pitch]RandRange(0.9, 1.1) );
}

//********************************************************************************
function bool TakeSpellEffect(baseSpell spell)
{
	local vector   start_locn;
	local bool     bIsVoldemortSpell;
	local rotator  r;
	local float    TempHeight, TempRadius;

	// Detect if the spell was from Voldemort

	if (spellVoldemortStraight(spell) != None)
		bIsVoldemortSpell = true;

	if (spellVoldemortTracking(spell) != None)
		bIsVoldemortSpell = true;

	if (bIsVoldemortSpell)
	{
		// If Voldemort shot the pillar, then blow it up

		start_locn = location;
		//start_locn.z -= collisionHeight;

		r = rotator( vect(0,0,1) );

		Disintegrate (start_locn, r);

		CurrentLife++;

		switch( CurrentLife )
		{
			case 1:
				Mesh = mesh'voldChallengeBrokeGargoyle2Mesh';
				//DrawScale = DrawScale*0.666;    //temporary
				//SetCollisionSize(CollisionRadius * 0.666, CollisionHeight * 0.666);
				break;
			case 2:
				Mesh = mesh'voldChallengeBrokeGargoyle3Mesh';
				//DrawScale = DrawScale*0.666;
				//SetCollisionSize(CollisionRadius * 0.666, CollisionHeight * 0.666);
				break;
			case 3:
				Destroy();
				break;
		}
	}
}


//********************************************************************************

defaultproperties
{
     NumShards=5
     CollisionRadius=40
     CollisionHeight=50
     bBlockActors=True
     bBlockPlayers=True
}
