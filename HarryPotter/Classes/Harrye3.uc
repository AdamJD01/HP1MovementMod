//=============================================================================
// Harry  -- hero character 
//=============================================================================
class Harrye3 extends Harry;





function PostBeginPlay()
{
 	Super.PostBeginPlay();
		baseWand(weapon).addSpell(Class'spellAloho');


}

defaultproperties
{
}
