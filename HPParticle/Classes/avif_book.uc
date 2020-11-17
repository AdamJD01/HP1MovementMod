//=============================================================================
// avif_book.
//=============================================================================
class avif_book expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=5,Rand=10)
     SourceWidth=(Base=20,Rand=10)
     SourceHeight=(Base=20,Rand=10)
     SourceDepth=(Base=20)
     AngularSpreadWidth=(Base=0)
     AngularSpreadHeight=(Base=0)
     bSteadyState=True
     Speed=(Base=5,Rand=15)
     Lifetime=(Rand=3)
     ColorStart=(Base=(R=249,G=203,B=66))
     ColorEnd=(Base=(R=228,G=41,B=102))
     SizeWidth=(Base=5,Rand=10)
     SizeLength=(Base=5,Rand=10)
     SizeEndScale=(Base=-2,Rand=4)
     SpinRate=(Base=-2,Rand=4)
     Chaos=5
     ChaosDelay=0.5
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_1'
     Rotation=(Pitch=16640)
}
