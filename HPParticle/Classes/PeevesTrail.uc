//=============================================================================
// PeevesTrail.
//=============================================================================
class PeevesTrail expands ParticleFX;

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPparticle.hp_fx
#exec OBJ LOAD FILE=..\textures\Particles.utx PACKAGE=HPparticle.particle_fx

defaultproperties
{
     ParticlesPerSec=(Base=100,Rand=100)
     SourceWidth=(Base=0,Rand=50)
     SourceHeight=(Base=0,Rand=100)
     SourceDepth=(Rand=50)
     AngularSpreadWidth=(Base=180,Rand=180)
     AngularSpreadHeight=(Base=180,Rand=180)
     bSteadyState=True
     Speed=(Base=1)
     Lifetime=(Rand=1)
     ColorStart=(Base=(R=0,G=0,B=255),Rand=(R=255,G=255,B=255))
     ColorEnd=(Base=(G=128),Rand=(R=128,G=128,B=128))
     SizeWidth=(Base=2,Rand=4)
     SizeLength=(Base=2,Rand=4)
     SizeEndScale=(Base=0,Rand=3)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'
     LastUpdateLocation=(Z=32)
     LastEmitLocation=(Z=32)
     LastUpdateRotation=(Pitch=16400)
     Age=643.2258
     ParticlesEmitted=50
     bDynamicLight=True
     Tag=Dummyparticle
     Location=(Z=32)
     Rotation=(Pitch=16400)
     OldLocation=(Z=32)
}
