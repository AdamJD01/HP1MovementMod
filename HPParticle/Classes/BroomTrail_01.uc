//=============================================================================
// BroomTrail_01.
//=============================================================================
class BroomTrail_01 expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=50,Rand=50)
     SourceWidth=(Base=0,Rand=50)
     SourceHeight=(Base=0,Rand=30)
     SourceDepth=(Rand=50)
     AngularSpreadWidth=(Base=180,Rand=180)
     AngularSpreadHeight=(Base=180,Rand=180)
     Speed=(Base=1)
     Lifetime=(Base=0,Rand=1)
     ColorStart=(Base=(R=0,G=0,B=255),Rand=(R=255,G=255,B=255))
     ColorEnd=(Base=(R=0,B=255),Rand=(R=255,G=128))
     SizeWidth=(Base=1,Rand=3)
     SizeLength=(Base=1,Rand=3)
     Chaos=1
     Attraction=(X=-0.01,Y=-0.01,Z=-0.01)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'
     bDynamicLight=True
}
