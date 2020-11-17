//=============================================================================
// Dummyparticle.
//=============================================================================
class Dummyparticle expands ParticleFX;

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPparticle.hp_fx
#exec OBJ LOAD FILE=..\textures\Particles.utx PACKAGE=HPparticle.particle_fx

defaultproperties
{
     ParticlesPerSec=(Rand=10)
     SourceWidth=(Base=50)
     SourceHeight=(Base=50)
     Speed=(Base=15,Rand=30)
     Lifetime=(Base=5)
     ColorStart=(Base=(R=149,G=166,B=244),Rand=(R=28,G=19,B=196))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=6,Rand=8)
     SizeLength=(Base=6,Rand=8)
     SizeEndScale=(Base=3)
     SpinRate=(Base=0.5)
     SizeDelay=2
     Chaos=1
     ChaosDelay=0.5
     Textures(0)=FireTexture'HPParticle.hp_fx.Particles.spin'
}
