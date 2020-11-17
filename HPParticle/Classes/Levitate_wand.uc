//=============================================================================
// Levitate_wand.
//=============================================================================
class Levitate_wand expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=60)
     SourceWidth=(Base=2)
     SourceHeight=(Base=2)
     AngularSpreadHeight=(Base=1)
     Speed=(Base=20)
     Lifetime=(Base=0.25)
     ColorStart=(Base=(R=169,G=184,B=241),Rand=(R=60,G=39,B=175))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=1)
     SizeLength=(Base=1)
     SizeEndScale=(Base=-1,Rand=10)
     SpinRate=(Base=1,Rand=20)
     Chaos=1
     GravityModifier=0.003
     Textures(0)=FireTexture'HPParticle.hp_fx.Particles.F_spark'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
