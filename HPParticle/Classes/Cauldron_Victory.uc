//=============================================================================
// Cauldron_Victory.
//=============================================================================
class Cauldron_Victory expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Rand=20)
     SourceWidth=(Base=50)
     SourceHeight=(Base=50)
     Speed=(Base=8,Rand=35)
     Lifetime=(Base=2,Rand=8)
     ColorStart=(Base=(R=230,G=239,B=255))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=5,Rand=20)
     SizeLength=(Base=5,Rand=20)
     SizeEndScale=(Base=-5,Rand=15)
     SpinRate=(Base=-4,Rand=8)
     Attraction=(X=5,Y=5)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke2'
}
