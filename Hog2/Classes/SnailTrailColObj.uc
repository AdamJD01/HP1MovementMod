class SnailTrailColObj expands Actor;

//var() bool bOnlyTriggerable;

auto state JustSittinThere
{
	//* * * * * * * * * * * * * * * * * * * * * * *
	function touch(actor other)
	{
		//	PlaySound(sound 'filch', SLOT_Interact, 3.2, false, 2000.0, 1.0);
		//	playerHarry.clientMessage(self $":" $other $" touched me!");
		//playerHarry.clientMessage(self $":touch");
		//gotostate('attackHarry');
		//playerHarry.clientMessage(self $":touch");

		if( harry(other)!=None )
		{
			if( !harry(other).IsInState('hit') )
			{
				// AE: sound of harry hitting the slime	trail.
				if( Rand(2) == 0 )
					PlaySound(sound'HPSounds.Snail_sfx.snail_hit_01', SLOT_none);
				else
					PlaySound(sound'HPSounds.Snail_sfx.snail_hit_02', SLOT_none);

				baseHarry(other).Acceleration = vect(0,0,0);
				harry(other).TakeDamage( 5, none, Location, Vect(0,0,0), '');
			}

			//if( harry(other).TakeSpellEffect(self) )
			//{
				//hitParticleEffect=Spawn(hitParticleEffectClass,,, HitLocation,rot(0,0,0));
				//hitParticleEffect.setRotation(hitParticleEffect.default.rotation);
				//reactParticleEffect=Spawn(reactParticleEffectClass,,, HitLocation,rot(0,0,0));
				//reactParticleEffect.setRotation(reactParticleEffect.default.rotation);
				//reactParticleEffect.SetOwner(other);
				//reactParticleEffect.SourceWidth.Base=baseProps(Other).collisionRadius;
			//}
		}

	}
}






//DrawType=DT_None

//If you change CollisionRadius, change the vLastGooSpawnLoc in Snail.uc

defaultproperties
{
     bNetTemporary=True
     DrawType=DT_None
     Mesh=SkeletalMesh'HarryPotter.skorangesnailMesh'
     bGameRelevant=True
     CollisionRadius=10
     CollisionHeight=5
     bCollideActors=True
}
