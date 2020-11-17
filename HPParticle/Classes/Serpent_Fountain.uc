//=============================================================================
// Serpent_Fountain.
//=============================================================================
class Serpent_Fountain expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Rand=10)
     SourceWidth=(Base=6)
     SourceHeight=(Base=6)
     bSteadyState=True
     Lifetime=(Base=2)
     ColorStart=(Base=(R=58,G=193,B=13))
     ColorEnd=(Base=(R=61,G=171,B=71))
     SizeWidth=(Base=12)
     SizeLength=(Base=3)
     SizeEndScale=(Base=4,Rand=3)
     GravityModifier=0.1
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_1'
     RenderPrimitive=PPRIM_Liquid
     Rotation=(Pitch=-6208,Yaw=128)
     bRotateToDesired=True
}
