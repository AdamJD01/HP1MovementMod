//=============================================================================
// ScrollFX.
//=============================================================================
class ScrollFX expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=5,Rand=20)
     SourceWidth=(Base=8,Rand=15)
     SourceHeight=(Base=2,Rand=10)
     SourceDepth=(Base=8,Rand=15)
     AngularSpreadWidth=(Base=10)
     AngularSpreadHeight=(Base=1)
     Speed=(Base=10,Rand=15)
     Lifetime=(Rand=5)
     ColorStart=(Base=(R=116,G=55,B=176),Rand=(R=168,G=84,B=237))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=2,Rand=8)
     SizeLength=(Base=2,Rand=8)
     SizeEndScale=(Base=0.1,Rand=20)
     SpinRate=(Base=0.5,Rand=20)
     SizeDelay=3
     Chaos=3
     ChaosDelay=1
     Attraction=(X=10,Y=10)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_4'
}
