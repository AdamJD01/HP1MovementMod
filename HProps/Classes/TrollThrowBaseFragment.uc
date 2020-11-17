//===============================================================================
//  [TrollThrowBaseFragment] 
//===============================================================================

class TrollThrowBaseFragment extends HProps;

var		FireSeedSmoke		Smoke;
var		vector				previouslocation;
var		rotator				FragSpin;

auto state() Flying
{
	function BeginState()
	{
		FragSpin.Pitch = RandRange( -1000, 1000 );
		FragSpin.yaw = RandRange( -1000, 1000 );
		FragSpin.roll = RandRange( -1000, 1000 );
	}

	function tick(float deltatime)
	{
		local sound snd;

		if (previouslocation == location)
		{
			Smoke = spawn(class'FireSeedSmoke', [spawnlocation] location);
			Smoke.ParticlesMax = 10;

			if(   TrollThrowFrag1(self) != none
			   || TrollThrowFrag2(self) != none
			   || TrollThrowFrag3(self) != none
			  )
			{
				if( FRand() < 0.5 )
					snd = sound'HPSounds.hub3_sfx.fall_sink_pieces';
				else
					snd = sound'HPSounds.hub3_sfx.fall_toilet_pieces';
			}
			else
			if( TrollThrowStoneShard(self) != none )
				snd = sound'HPSounds.hub3_sfx.fall_stone_pieces';
			else
			if(   TrollThrowToiletBroken1(self) != none
			   || TrollThrowToiletBroken2(self) != none )
				snd = sound'HPSounds.hub3_sfx.fall_toilet_pieces';
			else
			if( TrollThrowWoodBit(self) != none )
				snd = sound'HPSounds.hub3_sfx.fall_wood_pieces';
			else
				snd = sound'HPSounds.hub3_sfx.fall_pipe_pieces';

			PlaySound( snd, SLOT_None, [Volume]RandRange(0.8, 1.0), [Radius]100000, [Pitch]RandRange(0.7, 1.2) );

			Destroy();
		}
		else
		{
			SetRotation(Rotation + FragSpin);
		}

		PreviousLocation = location;
	}

	function HitWall( vector HitNormal, actor Wall )
	{
		Velocity *= 0.75;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );
	}
}

defaultproperties
{
}
