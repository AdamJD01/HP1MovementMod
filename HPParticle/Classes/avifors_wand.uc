//=============================================================================
// avifors_wand.
//=============================================================================
class avifors_wand expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=10,Rand=10)
     SourceWidth=(Base=2)
     SourceHeight=(Base=2)
     AngularSpreadWidth=(Base=10)
     AngularSpreadHeight=(Base=1)
     Speed=(Base=30,Rand=15)
     Lifetime=(Base=1.5)
     ColorStart=(Base=(G=171,B=15),Rand=(R=255,G=43,B=197))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=2,Rand=8)
     SizeLength=(Base=2,Rand=8)
     SizeEndScale=(Base=0.1)
     SpinRate=(Base=-1,Rand=10)
     SizeDelay=3
     Chaos=3
     ChaosDelay=1
     GravityModifier=0.05
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_3'
     Rotation=(Pitch=16640)
}
