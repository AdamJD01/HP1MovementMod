//=============================================================================
// Fire01.
//=============================================================================
class Fire01 expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=25,Rand=10)
     SourceWidth=(Base=24)
     SourceHeight=(Base=24)
     SourceDepth=(Base=10)
     AngularSpreadWidth=(Base=40)
     AngularSpreadHeight=(Base=40)
     Speed=(Base=25)
     Lifetime=(Base=0.9,Rand=0.5)
     SizeWidth=(Base=24)
     SizeLength=(Base=24)
     SizeEndScale=(Base=1.75,Rand=0.8)
     SpinRate=(Base=8,Rand=16)
     Gravity=(Z=50)
     Textures(0)=Texture'HPParticle.particle_fx.PotFire08'
}
