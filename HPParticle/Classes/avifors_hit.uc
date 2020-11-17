//=============================================================================
// avifors_hit.
//=============================================================================
class avifors_hit expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=5)
     Speed=(Base=20,Rand=30)
     Lifetime=(Base=0.5)
     ColorStart=(Base=(R=230,G=234,B=253))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=120,Rand=50)
     SizeLength=(Base=120,Rand=50)
     SpinRate=(Base=0.5)
     SizeDelay=2
     Chaos=3
     ChaosDelay=0.5
     ParticlesAlive=5
     ParticlesMax=5
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_1'
}
