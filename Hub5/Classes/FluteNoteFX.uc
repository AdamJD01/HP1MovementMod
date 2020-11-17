//=============================================================================
// FluteNoteFX.
//=============================================================================
class FluteNoteFX expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=0.5,Rand=1.5)
     SourceWidth=(Base=0)
     SourceHeight=(Base=0)
     AngularSpreadWidth=(Base=75)
     AngularSpreadHeight=(Base=75)
     bSteadyState=True
     Speed=(Base=20,Rand=20)
     Lifetime=(Base=5)
     ColorStart=(Base=(G=0,B=0),Rand=(G=128,B=255))
     ColorEnd=(Base=(R=155,G=155),Rand=(R=255,G=255))
     SizeWidth=(Base=4,Rand=4)
     SizeLength=(Base=4,Rand=4)
     SizeEndScale=(Base=0.5)
     SpinRate=(Base=-1,Rand=2)
     SizeGrowPeriod=0.1
     Chaos=5
     Damping=0.25
     Textures(0)=Texture'HPParticle.hp_fx.Particles.M_note'
     Age=310.9202
     Tag=FluteNoteFX
}
