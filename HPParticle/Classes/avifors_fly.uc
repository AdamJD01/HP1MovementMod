//=============================================================================
// avifors_fly.
//=============================================================================
class avifors_fly expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=80,Rand=10)
     SourceWidth=(Base=2)
     SourceHeight=(Base=2)
     AngularSpreadWidth=(Base=10)
     AngularSpreadHeight=(Base=10)
     Speed=(Base=30,Rand=15)
     Lifetime=(Base=3)
     ColorStart=(Base=(G=171,B=15),Rand=(R=255,G=43,B=197))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=25)
     SizeLength=(Base=25)
     SizeEndScale=(Base=-1)
     SpinRate=(Base=5,Rand=10)
     Chaos=3
     GravityModifier=0.05
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_3'
     Rotation=(Pitch=16640)
}
