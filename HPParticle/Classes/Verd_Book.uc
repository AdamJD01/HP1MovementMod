//=============================================================================
// Verd_Book.
//=============================================================================
class Verd_Book expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=5,Rand=20)
     SourceWidth=(Base=15,Rand=15)
     SourceHeight=(Base=15,Rand=15)
     SourceDepth=(Base=8,Rand=15)
     AngularSpreadWidth=(Rand=10)
     AngularSpreadHeight=(Rand=10)
     bSteadyState=True
     Speed=(Base=10,Rand=30)
     Lifetime=(Rand=3)
     ColorStart=(Base=(R=31,G=220,B=31))
     ColorEnd=(Base=(R=60,G=124,B=29))
     SizeWidth=(Base=2)
     SizeLength=(Base=1,Rand=10)
     SizeEndScale=(Base=-1,Rand=10)
     SizeDelay=1
     Chaos=5
     ChaosDelay=0.5
     Attraction=(X=6,Y=6,Z=2)
     Damping=0.25
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_2'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
