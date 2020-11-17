//=============================================================================
// SilverSparkle01.
//=============================================================================
//class SilverSparkle01 expands BronzeSparkle01;
class SilverSparkle01 expands ParticleFX;

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPparticle.hp_fx
#exec OBJ LOAD FILE=..\textures\Particles.utx PACKAGE=HPparticle.particle_fx

//    Textures(0)=Texture'HPParticle.hp_fx.Particles.rep_p'

/*    ColorStart=(Base=(R=255,G=255,B=255),Max=(R=0,G=0,B=0),Rand=(R=0,G=0,B=0))
    ColorEnd=(Base=(R=0,G=0,B=255))
*/

/*    ColorStart=(Base=(R=128,G=128,B=128),Max=(R=0,G=0,B=0),Rand=(R=0,G=0,B=0))
    ColorEnd=(Base=(R=128,G=128,B=128))
    Textures(0)=Texture'HPParticle.hp_fx.Particles.SilverSparkle01'
*/

defaultproperties
{
     ParticlesPerSec=(Base=3)
     SourceWidth=(Base=0)
     SourceHeight=(Base=0)
     AngularSpreadWidth=(Base=0)
     AngularSpreadHeight=(Base=0)
     Speed=(Base=0)
     Lifetime=(Base=0)
     ColorStart=(Base=(R=96,G=96,B=96))
     ColorEnd=(Base=(R=96,G=96,B=96))
     Distribution=DIST_Uniform
}
