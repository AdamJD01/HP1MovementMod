//=============================================================================
// Aloh_Book.
//=============================================================================
class Aloh_Book expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=5,Rand=30)
     SourceWidth=(Base=15,Rand=15)
     SourceHeight=(Base=15,Rand=15)
     SourceDepth=(Base=8,Rand=15)
     AngularSpreadWidth=(Rand=10)
     AngularSpreadHeight=(Rand=10)
     bSteadyState=True
     Speed=(Base=5,Rand=30)
     Lifetime=(Rand=3)
     ColorStart=(Base=(G=255,B=255),Rand=(R=253,G=45))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=2,Rand=8)
     SizeLength=(Base=2,Rand=8)
     SizeEndScale=(Base=-1,Rand=10)
     SpinRate=(Base=-2,Rand=4)
     SizeDelay=1
     Chaos=10
     ChaosDelay=2
     Attraction=(Z=2)
     GravityModifier=0.005
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Key1'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
