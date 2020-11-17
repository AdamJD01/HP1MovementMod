class BaseBossQuirrel expands baseBoss;

//*************************************************************************************************************************

function ShootStraightSpellAtHarry(bool bDoLookAhead)
{
	local vector  v;
	local rotator r;

	baseWand(weapon).SelectSpell(Class'spellVoldemortStraight');
	//Multiply harry's velocity by .8 or so.  The lookahead code seems to overshoot

	//Allright, since QuirrelFlip is the only one who uses this, I'm going to change it so it looks ahead a bunch.

	if( bDoLookAhead )
	{
		v = AdjustAimLookAhead( playerHarry.Location, playerHarry.Velocity * 1.0/*0.7*/, Location, 575); //the speed needs to match the default props in spellVoldemortStraight
		r = rotation;
		SetRotation( rotator(v) );
		baseWand(weapon).CastSpell( none /*playerHarry*/ );
		SetRotation( r );
	}
	else
	{
		baseWand(weapon).CastSpell( none /*playerHarry*/ );
	}
}

//*************************************************************************************************************************

defaultproperties
{
}
