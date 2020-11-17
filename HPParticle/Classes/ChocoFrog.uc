//=============================================================================
// ChocoFrog.
//=============================================================================
class ChocoFrog expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=10,Rand=15)
     SourceWidth=(Base=20,Rand=10)
     SourceHeight=(Base=20,Rand=10)
     SourceDepth=(Base=10,Rand=20)
     AngularSpreadWidth=(Base=10,Rand=20)
     AngularSpreadHeight=(Base=10,Rand=20)
     Speed=(Base=5,Rand=20)
     Lifetime=(Base=7)
     ColorStart=(Base=(R=0,G=0,B=0))
     ColorEnd=(Base=(R=172,G=130),Rand=(R=253,G=88))
     SizeWidth=(Base=1,Rand=10)
     SizeLength=(Base=1,Rand=10)
     SizeEndScale=(Base=2)
     SpinRate=(Base=0.2,Rand=2)
     SizeDelay=2
     Chaos=1
     ChaosDelay=0.5
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_1'
     Rotation=(Pitch=-16352)
     DesiredRotation=(Pitch=-16352)
}
