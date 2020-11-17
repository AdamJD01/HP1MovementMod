//=============================================================================
// WaterShowerFXBase - For growing plant scene.
//=============================================================================
class WaterShowerFXBase expands ParticleFadeFX;

// Needs to ramp ParticlePerSec Base and Rand from 0 to the new defaults
// on trigger, then back to 0 after what ever time it takes for the plant to
// grow.

defaultproperties
{
     ParticlesPerSec=(Base=30,Rand=10)
     SourceWidth=(Base=0)
     SourceHeight=(Base=0)
     AngularSpreadWidth=(Base=50,Rand=5)
     AngularSpreadHeight=(Base=50,Rand=5)
     bSteadyState=True
     Speed=(Rand=30)
     Lifetime=(Base=1.65)
     ColorStart=(Base=(R=1,G=205,B=143))
     ColorEnd=(Base=(R=23,G=255,B=35),Rand=(R=159,B=4))
     SizeWidth=(Rand=4)
     SizeLength=(Base=2,Rand=3)
     SizeEndScale=(Base=0.4,Rand=3)
     AlphaDelay=1
     Attraction=(X=1,Y=1)
     Damping=0.3
     GravityModifier=0.25
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_1'
     RenderPrimitive=PPRIM_Liquid
     Rotation=(Pitch=16384)
     CollisionRadius=60
     CollisionHeight=250
     bRotateToDesired=True
     DesiredRotation=(Pitch=0)
}
