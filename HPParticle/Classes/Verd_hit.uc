//=============================================================================
// Verd_hit.
//=============================================================================
class Verd_hit expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=30)
     SourceWidth=(Base=20,Rand=30)
     SourceHeight=(Base=20,Rand=30)
     SourceDepth=(Base=60,Rand=30)
     AngularSpreadWidth=(Base=40)
     AngularSpreadHeight=(Base=40)
     bSteadyState=True
     Speed=(Base=10,Rand=40)
     Lifetime=(Base=3)
     ColorStart=(Base=(R=15,G=217,B=4),Rand=(R=64,G=114,B=56))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=15)
     SizeLength=(Base=15)
     SizeEndScale=(Base=-5,Rand=2)
     SpinRate=(Base=-2,Rand=4)
     Chaos=5
     Attraction=(X=20,Y=20)
     ParticlesMax=200
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_8'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
