//=============================================================================
// Aloh_hit.
//=============================================================================
class FireCrackerExplode expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=4)
     SourceWidth=(Base=4)
     SourceHeight=(Base=4)
     SourceDepth=(Base=4)
     AngularSpreadWidth=(Base=180)
     AngularSpreadHeight=(Base=180)
     bSteadyState=True
     Speed=(Base=10,Rand=5)
     Lifetime=(Base=2)
     ColorStart=(Base=(G=255,B=255),Rand=(R=253,G=45))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=6,Rand=8)
     SizeLength=(Base=6,Rand=8)
     SizeEndScale=(Base=2,Rand=4)
     SpinRate=(Base=-2,Rand=4)
     GravityModifier=0.005
     ParticlesMax=20
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Key1'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
