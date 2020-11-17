//=============================================================================
// Aloh_hit.
//=============================================================================
class Aloh_hit expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=75)
     SourceWidth=(Base=20,Rand=20)
     SourceHeight=(Base=20,Rand=20)
     SourceDepth=(Base=20,Rand=20)
     AngularSpreadWidth=(Base=180)
     AngularSpreadHeight=(Base=180)
     bSteadyState=True
     Speed=(Base=200,Rand=200)
     ColorStart=(Base=(G=255,B=255))
     ColorEnd=(Base=(R=253,B=6))
     SizeWidth=(Base=2,Rand=8)
     SizeLength=(Base=2,Rand=8)
     SizeEndScale=(Base=2,Rand=4)
     SpinRate=(Base=-6,Rand=12)
     Chaos=1
     Damping=9
     GravityModifier=-0.1
     ParticlesMax=75
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Key1'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
