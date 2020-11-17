//=============================================================================
// Levitate_fly.
//=============================================================================
class Levitate_fly expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=80)
     SourceWidth=(Base=2)
     SourceHeight=(Base=2)
     AngularSpreadWidth=(Base=10)
     AngularSpreadHeight=(Base=10)
     Speed=(Base=20,Rand=30)
     Lifetime=(Base=2)
     ColorStart=(Base=(G=255,B=255),Rand=(R=54,G=44,B=245))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=20,Rand=20)
     SizeLength=(Base=20,Rand=20)
     SizeEndScale=(Base=-0.5)
     SpinRate=(Base=2)
     bVelocityRelative=True
     Chaos=3
     GravityModifier=-0.01
     Textures(0)=FireTexture'HPParticle.hp_fx.Particles.F_spark'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
