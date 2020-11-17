//=============================================================================
// FallingWisps.
//=============================================================================
class FallingWisps expands ParticleFX;

defaultproperties
{
     SourceDepth=(Base=15)
     AngularSpreadWidth=(Base=90,Rand=20)
     AngularSpreadHeight=(Base=90,Rand=20)
     Speed=(Base=5,Rand=15)
     Lifetime=(Base=2,Rand=5)
     ColorStart=(Base=(R=0,G=0,B=0))
     ColorEnd=(Base=(G=255,B=255))
     SizeWidth=(Base=1,Rand=15)
     SizeLength=(Base=1,Rand=15)
     SizeEndScale=(Base=-1)
     Attraction=(X=5,Y=5)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_2'
     Rotation=(Pitch=-16352)
     DesiredRotation=(Pitch=-16352)
}
