class E3Knight extends Knight;//baseChar;

//var int NumSpellHits;
//
////**************************************************************
//auto state idle
//{
//	function bool HandleFlipSpell()
//	{
//		local FireCracker  a;
//		local byte         b;
//		local int          i;
//
//		NumSpellHits++;
//
//		if( NumSpellHits >= 3 )
//		{
//			Playsound( sound 'HPSounds.hub1_sfx.MAL_candy_explodes');
//			PlaySound( sound'HPSounds.menu_sfx.s_menu_click', SLOT_Interact, 1.0, false, 1000.0, 1.0);
//
//			for( i = 0; i < 10; i++ )
//			{
//				a = spawn( class'FireCracker' ); //cWizCrackerConfetti' );
//
//				b = 127 + Rand(128);
//				a.ColorStart.Base.r = b;
//				a.ColorStart.Base.g = b;
//				a.ColorStart.Base.b = b;
//				a.ColorEnd.Base.r = b;
//				a.ColorEnd.Base.g = b;
//				a.ColorEnd.Base.b = b;
//
//				a.Gravity.z = -(30 + Rand(4)*30);
//			}
//
//			Destroy();	
//		}
//		else
//		{
//			GotoState('stateWobble');
//		}
//	}
//
//  begin:
//  loop:
//	LoopAnim('IDLE2LOOKRIGHT', 1.0, 0.0);
//	finishanim();
//	LoopAnim('LOOKRIGHT', 1.0, 0.0);
//	sleep(frand()*2);
//	finishanim();
//	LoopAnim('LOOKRIGHT2IDLE', 1.0, 0.0);
//	finishanim();
//	LoopAnim('IDLE', 1.0, 0.0);
//	sleep(frand()*3);
//	finishanim();
//
//	LoopAnim('IDLE2LOOKLEFT', 1.0, 0.0);
//	finishanim();
//	LoopAnim('LOOKLEFT', 1.0, 0.0);
//	sleep(frand()*2);
//	finishanim();
//	LoopAnim('LOOKLEFT2IDLE', 1.0, 0.0);
//	finishanim();
//	LoopAnim('IDLE', 1.0, 0.0);
//	sleep(frand()*3);
//	finishanim();
//
//	goto 'loop';
//}
//
////**************************************************************
//state stateWobble
//{
//  Begin:
//	PlayAnim('wobble');
//	FinishAnim();
//	GotoState('idle');
//}
//
////**************************************************************
//defaultProperties
//{
//     DrawType=DT_Mesh
//     Mesh=SkeletalMesh'HarryPotter.skKnightMesh'
//	 eVulnerableToSpell=SPELL_Flipendo
//}

defaultproperties
{
}
