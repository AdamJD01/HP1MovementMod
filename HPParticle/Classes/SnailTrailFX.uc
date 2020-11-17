//=============================================================================
// Snail trial particle fx
//=============================================================================
class SnailTrailFX expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=40)
     SourceWidth=(Base=15)
     SourceHeight=(Base=0)
     SourceDepth=(Base=10)
     AngularSpreadWidth=(Base=30)
     AngularSpreadHeight=(Base=0)
     Speed=(Base=0)
     Lifetime=(Base=3)
     ColorStart=(Base=(G=100,B=6))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=6)
     SizeLength=(Base=6)
     SizeEndScale=(Base=2)
     SpinRate=(Base=0.5,Rand=10)
     AlphaDelay=6
     GravityModifier=0.0001
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_1'
     Rotation=(Pitch=16640)
     CollisionRadius=400
     bRotateToDesired=True
}
