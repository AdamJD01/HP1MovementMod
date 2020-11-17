class BossTroll expands BossRailMove;


//*************************************************************************************************************************
// get rid of this when the strafe anims are done
function PlayRunAnim()
{
	loopAnim('walk', 2);
}

//*************************************************************************************************************************
state throwing
{
	begin:
		PlayAnim('swing', 2, 0.5);

		sleep( 1.2 );
		target = playerHarry;
		baseWand(weapon).SelectSpell(SpellToCast);
		baseWand(weapon).CastSpell(playerHarry);

		baseWand(weapon).LastCastedSpell.target = none;  //no autotargetting

		finishanim();

		FindNewMoveToLoc();
		gotostate('PatrolForHarry');
}

//*************************************************************************************************************************
function PlayHitSfx()
{
	//switch( Rand(3) )
	//{
	//	case 0:		PlaySound(sound'Har_201_25');    break;
	//	case 1:		PlaySound(sound'Har_lumos');     break;
	//	case 2:		PlaySound(sound'Har_nox');     break;
	//}
}


//*************************************************************************************************************************

defaultproperties
{
     SpellToCast=Class'HPBase.spellTrollRock'
     Mesh=SkeletalMesh'HPModels.skmountaintrollMesh'
}
