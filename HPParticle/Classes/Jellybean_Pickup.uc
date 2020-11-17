//=============================================================================
// Jellybean_Pickup.
//=============================================================================
class Jellybean_Pickup expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=20)
     AngularSpreadWidth=(Base=90)
     AngularSpreadHeight=(Base=90)
     Speed=(Base=20,Rand=15)
     Lifetime=(Base=1.5)
     ColorStart=(Base=(R=201,G=163,B=222))
     ColorEnd=(Base=(R=0))
     SizeEndScale=(Base=2)
     SpinRate=(Base=1,Rand=20)
     SizeDelay=1
     Attraction=(X=20,Y=20)
     ParticlesMax=50
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_4'
}
