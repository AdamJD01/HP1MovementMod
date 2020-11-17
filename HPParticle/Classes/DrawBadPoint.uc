//=============================================================================
// DrawBadPoint.
//=============================================================================
class DrawBadPoint expands ParticleFX;

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPparticle.hp_fx
#exec OBJ LOAD FILE=..\textures\Particles.utx PACKAGE=HPparticle.particle_fx

defaultproperties
{
     ParticlesPerSec=(Base=3)
     SourceWidth=(Base=0)
     SourceHeight=(Base=0)
     AngularSpreadWidth=(Base=0)
     AngularSpreadHeight=(Base=0)
     Speed=(Base=0)
     Lifetime=(Base=60)
     ColorStart=(Base=(R=0,G=0,B=0))
     ColorEnd=(Base=(R=0))
     Distribution=DIST_Uniform
}
