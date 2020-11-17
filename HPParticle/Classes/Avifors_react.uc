//=============================================================================
// Avifors_react.
//=============================================================================
class Avifors_react expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=1,Rand=2)
     SourceWidth=(Base=0.5)
     SourceHeight=(Base=0.5)
     SourceDepth=(Base=5)
     Speed=(Base=10)
     Lifetime=(Base=6)
     ColorStart=(Base=(G=255,B=255))
     ColorEnd=(Base=(G=255,B=255))
     SpinRate=(Base=1.5,Rand=0.5)
     Chaos=8
     ChaosDelay=0.75
     Elasticity=0.5
     Damping=0.75
     GravityModifier=0.002
     ParticlesAlive=8
     ParticlesMax=8
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Feather'
     Style=STY_Masked
}
