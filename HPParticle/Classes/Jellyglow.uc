//=============================================================================
// Jellyglow.
//=============================================================================
class Jellyglow expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=10)
     SourceWidth=(Base=15)
     SourceHeight=(Base=15)
     SourceDepth=(Base=15)
     AngularSpreadWidth=(Base=2)
     AngularSpreadHeight=(Base=2)
     Speed=(Base=2)
     Lifetime=(Base=2)
     ColorStart=(Base=(R=157,G=101,B=203))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=2,Rand=10)
     SizeLength=(Base=2,Rand=10)
     SizeEndScale=(Base=-0.5)
     SpinRate=(Base=0.5,Rand=10)
     Attraction=(X=10,Y=10)
     ParticlesAlive=10
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_1'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
