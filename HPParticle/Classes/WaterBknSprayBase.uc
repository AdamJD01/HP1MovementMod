//=============================================================================
// WaterBknSpray.
//=============================================================================
class WaterBknSprayBase expands WaterShowerFX;

defaultproperties
{
     ParticlesPerSec=(Base=5,Rand=25)
     AngularSpreadWidth=(Base=20,Rand=20)
     AngularSpreadHeight=(Base=60,Rand=20)
     Speed=(Base=170)
     Lifetime=(Base=0.5)
     ColorStart=(Base=(R=0,G=206,B=83),Rand=(R=99,G=68,B=39))
     ColorEnd=(Base=(R=61,G=88,B=70),Rand=(R=47,G=77,B=85))
     SizeWidth=(Base=4)
     AlphaDelay=0.4
     ColorDelay=0.2
     Attraction=(X=0,Y=0)
     Damping=0
     GravityModifier=0.3
     CollisionRadius=120
     CollisionHeight=120
}
