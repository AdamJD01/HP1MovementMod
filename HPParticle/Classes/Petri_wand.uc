//=============================================================================
// Petri_wand.
//=============================================================================
class Petri_wand expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=20)
     SourceWidth=(Base=1)
     SourceHeight=(Base=1)
     AngularSpreadWidth=(Base=0)
     AngularSpreadHeight=(Base=0)
     bSteadyState=True
     Speed=(Base=10)
     Lifetime=(Base=5,Rand=2)
     ColorStart=(Base=(R=128,B=128))
     ColorEnd=(Base=(R=30,G=30,B=30))
     SizeWidth=(Base=3,Rand=1)
     SizeLength=(Rand=2)
     SizeEndScale=(Base=3)
     DripTime=(Base=0.2)
     Attraction=(X=35,Y=35)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_5'
     LastUpdateLocation=(X=-388.5305,Y=-383.679,Z=60.94167)
     LastEmitLocation=(X=-388.5305,Y=-383.679,Z=60.94167)
     LastUpdateRotation=(Pitch=16528,Yaw=-16336)
     EmissionResidue=0.149399
     Age=20429.72
     bDynamicLight=True
     Tag=ParticleFX
     Location=(X=-388.5305,Y=-383.679,Z=60.94167)
     Rotation=(Pitch=16528,Yaw=-16336)
     OldLocation=(X=-32,Y=64,Z=96)
}
