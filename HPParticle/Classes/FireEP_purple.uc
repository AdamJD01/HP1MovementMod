//=============================================================================
// FireEP_purple.
//
// Purple Fire for Potions puzzle at the end of the game.
//
//=============================================================================
class FireEP_purple expands FireEP_black;

defaultproperties
{
     ColorStart=(Base=(R=243,G=102))
     ColorEnd=(Base=(R=130,G=33,B=137))
     SizeEndScale=(Base=0.1,Rand=0.4)
     AlphaDelay=1.2
     Textures(0)=Texture'HPParticle.hp_fx.Particles.purplefire'
     Age=126.6146
     Tag=FireEP_purple
     Style=STY_Translucent
}
