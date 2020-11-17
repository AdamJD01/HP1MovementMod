//=============================================================================
// Target2FX.
//=============================================================================
class Target2FX expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=20)
     SourceWidth=(Base=3)
     SourceHeight=(Base=3)
     SourceDepth=(Base=3)
     Speed=(Base=0)
     Lifetime=(Base=0.55)
     ColorStart=(Base=(R=13,G=108,B=2))
     ColorEnd=(Base=(R=51,G=142,B=97))
     SizeWidth=(Base=12)
     SizeLength=(Base=12)
     SizeEndScale=(Base=1.25)
     SpinRate=(Base=4,Rand=-8)
     Textures(0)=Texture'HPParticle.particle_fx.soft_pfx'
}
