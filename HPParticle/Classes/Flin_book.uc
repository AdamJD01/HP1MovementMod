//=============================================================================
// Flin_book.
//=============================================================================
class Flin_book expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=10,Rand=15)
     SourceWidth=(Base=20,Rand=10)
     SourceHeight=(Base=20,Rand=10)
     SourceDepth=(Base=20)
     AngularSpreadWidth=(Base=0)
     AngularSpreadHeight=(Base=0)
     bSteadyState=True
     Speed=(Base=10,Rand=50)
     Lifetime=(Rand=3)
     ColorStart=(Base=(R=254,G=134,B=69))
     ColorEnd=(Base=(R=243,G=37,B=227))
     AlphaStart=(Base=0,Rand=1)
     SizeWidth=(Base=5,Rand=30)
     SizeLength=(Base=5,Rand=30)
     SizeEndScale=(Base=-1,Rand=3)
     SpinRate=(Base=-4,Rand=8)
     Chaos=5
     ChaosDelay=0.5
     Damping=1
     Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'
     Rotation=(Pitch=16640)
}
