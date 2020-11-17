//=============================================================================
// Doxie_fx.
//=============================================================================
class Doxie_fx expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=20)
     SourceWidth=(Base=2)
     SourceHeight=(Base=2)
     SourceDepth=(Base=20)
     AngularSpreadWidth=(Base=180)
     AngularSpreadHeight=(Base=180)
     bSteadyState=True
     Speed=(Base=20,Rand=10)
     Lifetime=(Base=2,Rand=1)
     ColorStart=(Base=(R=89,G=131,B=255))
     ColorEnd=(Base=(R=72,G=63,B=194))
     SizeWidth=(Base=6,Rand=2)
     SizeLength=(Base=6,Rand=2)
     SizeEndScale=(Base=0)
     SpinRate=(Base=-4,Rand=8)
     Chaos=5
     ChaosDelay=0.5
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_5'
     Rotation=(Pitch=-16352)
     DesiredRotation=(Pitch=-16352)
}
