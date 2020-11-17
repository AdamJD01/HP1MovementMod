//=============================================================================
// Lumos_fly.
//=============================================================================
class Lumos_fly expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=80,Rand=10)
     SourceWidth=(Rand=10)
     SourceHeight=(Rand=10)
     SourceDepth=(Base=10,Rand=10)
     AngularSpreadWidth=(Base=180)
     AngularSpreadHeight=(Base=180)
     Speed=(Base=30)
     Lifetime=(Rand=1)
     ColorStart=(Base=(R=250,G=206,B=1))
     ColorEnd=(Base=(R=185,G=151,B=255))
     SizeWidth=(Base=1,Rand=2)
     SizeLength=(Base=1,Rand=2)
     SizeEndScale=(Base=20,Rand=5)
     SpinRate=(Base=-2,Rand=4)
     Chaos=1
     Attraction=(Z=5)
     Textures(0)=Texture'HPParticle.hp_fx.General.CandleF'
     LastUpdateLocation=(X=-383.86,Y=-178.5758,Z=65.73093)
     LastEmitLocation=(X=-383.86,Y=-178.5758,Z=65.73093)
     LastUpdateRotation=(Pitch=16144,Yaw=-16336)
     EmissionResidue=0.810257
     Age=13676.87
     Tag=ParticleFX
     Location=(X=-383.86,Y=-178.5758,Z=65.73093)
     Rotation=(Pitch=16144,Yaw=-16336)
     OldLocation=(X=1.133467,Y=115.5254,Z=68.5724)
}
