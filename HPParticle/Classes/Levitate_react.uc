//=============================================================================
// Levitate_react.
//=============================================================================
class Levitate_react expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=50)
     SourceWidth=(Base=48)
     SourceHeight=(Base=48)
     Decay=(Rand=1)
     AngularSpreadWidth=(Base=0,Rand=8)
     AngularSpreadHeight=(Base=0,Rand=8)
     bSteadyState=True
     Speed=(Base=15,Rand=25)
     Lifetime=(Base=3,Rand=2)
     ColorStart=(Base=(R=191,G=191,B=255))
     ColorEnd=(Base=(R=138,G=141,B=255))
     SizeWidth=(Base=30,Rand=10)
     SizeLength=(Base=30,Rand=10)
     SizeEndScale=(Base=2)
     SpinRate=(Base=1,Rand=5)
     DripTime=(Base=1.5,Rand=1.5)
     Textures(0)=FireTexture'HPParticle.hp_fx.Particles.F_spark'
     Rotation=(Pitch=16640)
}
