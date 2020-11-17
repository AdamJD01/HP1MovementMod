//=============================================================================
// levitate_hit.
//=============================================================================
class levitate_hit expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=5)
     Speed=(Base=20,Rand=30)
     Lifetime=(Base=0.5)
     ColorStart=(Base=(R=149,G=166,B=244),Rand=(R=28,G=19,B=196))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=120,Rand=50)
     SizeLength=(Base=120,Rand=50)
     SpinRate=(Base=2)
     SizeDelay=2
     Chaos=3
     ChaosDelay=0.5
     ParticlesAlive=5
     ParticlesMax=5
     Textures(0)=FireTexture'HPParticle.hp_fx.Particles.spin'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
