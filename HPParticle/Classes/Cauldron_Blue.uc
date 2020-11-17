//=============================================================================
// Cauldron_Blue.
//=============================================================================
class Cauldron_Blue expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Rand=20)
     SourceWidth=(Base=50)
     SourceHeight=(Base=50)
     bSteadyState=True
     Speed=(Base=8,Rand=35)
     Lifetime=(Base=2,Rand=8)
     ColorStart=(Base=(R=12,G=0,B=225),Rand=(R=156,G=111,B=213))
     ColorEnd=(Base=(R=0))
     SizeWidth=(Base=12,Rand=15)
     SizeLength=(Base=12,Rand=15)
     SizeEndScale=(Base=-1,Rand=5)
     SpinRate=(Base=0.5)
     SizeDelay=1
     Chaos=1
     ChaosDelay=0.5
     GravityModifier=0.011
     Gravity=(X=-2,Y=-2)
     Textures(0)=FireTexture'HPParticle.hp_fx.Particles.spin'
}
