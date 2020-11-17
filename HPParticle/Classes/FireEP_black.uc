//=============================================================================
// FireEP_black.
//
// Black Fire for use in the Potions puzzle at the end of the game.
//
//=============================================================================
class FireEP_black expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=80,Rand=10)
     SourceWidth=(Base=16)
     SourceHeight=(Base=96)
     SourceDepth=(Base=8)
     AngularSpreadWidth=(Base=40)
     AngularSpreadHeight=(Base=20)
     bSteadyState=True
     Speed=(Base=25)
     Lifetime=(Base=1.5)
     ColorStart=(Base=(G=255,B=255))
     ColorEnd=(Base=(G=255,B=255))
     SizeWidth=(Base=40)
     SizeLength=(Base=30)
     SizeEndScale=(Base=0.05,Rand=0.1)
     SpinRate=(Base=-8,Rand=16)
     SizeDelay=1.3
     Chaos=9
     Attraction=(X=0.7,Y=4)
     Damping=0.4
     Gravity=(Z=80)
     Textures(0)=Texture'HPParticle.hp_fx.Particles.blackfire'
     Age=518.4659
     Style=STY_Modulated
     CollisionRadius=70
     CollisionHeight=140
}
