//=============================================================================
// Flip_fly.
//=============================================================================
class Flip_fly expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=100)
     SourceWidth=(Base=1)
     SourceHeight=(Base=1)
     AngularSpreadWidth=(Base=180)
     AngularSpreadHeight=(Base=180)
     bSteadyState=True
     Speed=(Base=75)
     ColorStart=(Base=(G=255,B=255),Rand=(R=133,G=133,B=133))
     ColorEnd=(Base=(G=4,B=11))
     SizeWidth=(Base=4,Rand=9)
     SizeLength=(Base=4,Rand=9)
     SizeEndScale=(Base=7)
     SpinRate=(Base=-3,Rand=6)
     AlphaGrowPeriod=0.1
     Attraction=(X=10,Y=10,Z=10)
     Damping=1
     Textures(0)=Texture'HPParticle.hp_fx.Spells.Particle_02'
     LastUpdateLocation=(X=132,Y=-348,Z=-44.50056)
     LastEmitLocation=(X=132,Y=-348,Z=-44.50056)
     LastUpdateRotation=(Pitch=16464)
     EmissionResidue=0.03827667
     Age=1139.42
     ParticlesEmitted=53159
     bDynamicLight=True
     Tag=Dummyparticle
     Location=(X=132,Y=-348,Z=-44.50056)
     OldLocation=(Z=32)
     bSelected=True
}
