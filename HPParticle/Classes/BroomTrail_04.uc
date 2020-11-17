//=============================================================================
// BroomTrail_04.
//=============================================================================
class BroomTrail_04 expands BroomTrail_01;

defaultproperties
{
     ParticlesPerSec=(Base=0)
     SourceWidth=(Rand=35)
     SourceHeight=(Rand=35)
     SourceDepth=(Rand=35)
     Lifetime=(Base=1)
     ColorStart=(Base=(R=255,B=0))
     ColorEnd=(Base=(R=255,G=255,B=0),Rand=(G=255,B=255))
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_02'
}
