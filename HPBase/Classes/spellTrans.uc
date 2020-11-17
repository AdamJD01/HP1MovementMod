//=============================================================================
// spellTrans.
//=============================================================================
class spellTrans extends baseSpell;


#EXEC TEXTURE IMPORT NAME=transSpellIcon  FILE=TEXTURES\transSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.transSpellIcon'
     spellName="Transform"
     hitEffect=Class'HPBase.transHitEffect'
     Speed=30
     Damage=0
}
