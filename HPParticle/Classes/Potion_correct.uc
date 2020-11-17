//=============================================================================
// Potion_correct.
//=============================================================================
class Potion_correct expands ParticleFX;

defaultproperties
{
     SourceWidth=(Base=20,Rand=10)
     SourceHeight=(Base=20,Rand=10)
     SourceDepth=(Base=5)
     AngularSpreadWidth=(Base=60)
     AngularSpreadHeight=(Base=60)
     bSteadyState=True
     Speed=(Base=10)
     Lifetime=(Base=2,Rand=3)
     ColorStart=(Base=(R=130,G=130,B=130))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=15)
     SizeLength=(Base=15)
     SizeEndScale=(Base=-1,Rand=20)
     SpinRate=(Base=-3,Rand=6)
     Chaos=5
     Damping=0.2
     GravityModifier=-0.02
     ParticlesMax=75
     Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke2'
     Rotation=(Pitch=16640)
     bRotateToDesired=True
}
