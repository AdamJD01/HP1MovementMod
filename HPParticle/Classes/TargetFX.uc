//=============================================================================
// TargetFX.
//=============================================================================
class TargetFX expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=20)
     SourceWidth=(Base=3)
     SourceHeight=(Base=3)
     SourceDepth=(Base=3)
     Speed=(Base=0)
     Lifetime=(Base=0.55)
     ColorStart=(Base=(R=5,G=5,B=169))
     ColorEnd=(Base=(R=113,B=204))
     SizeWidth=(Base=12)
     SizeLength=(Base=12)
     SizeEndScale=(Base=1.25)
     SpinRate=(Base=4,Rand=-8)
     Textures(0)=Texture'HPParticle.particle_fx.soft_pfx'
}
