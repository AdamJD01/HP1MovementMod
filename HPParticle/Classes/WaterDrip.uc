//=============================================================================
// WaterDrip.
//=============================================================================
class WaterDrip expands ParticleFX;

defaultproperties
{
     ParticlesPerSec=(Base=0.25)
     SourceDepth=(Base=2)
     Speed=(Base=0)
     Lifetime=(Base=3.5)
     ColorStart=(Base=(R=16,G=197,B=197))
     ColorEnd=(Base=(R=28,G=170,B=163))
     AlphaEnd=(Base=0.9)
     SizeWidth=(Base=4)
     SizeLength=(Base=4)
     DripTime=(Base=0.25)
     Elasticity=0.1
     Gravity=(Z=-200)
     RenderPrimitive=PPRIM_Liquid
     CollisionHeight=512
}
