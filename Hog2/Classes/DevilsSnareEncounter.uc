class DevilsSnareEncounter expands baseBoss;

var()  bool   bSlaveSnare;

var()  float  fTimeLimit;
var    bool   bGrowing;

var()  bool   bRandomizePlants;

//*************************************************************************************************************************
function PostBeginPlay()
{
	local DevilsSnare  a;
	local DevilsSnare  ds[5];
	local int          i, count;
	local float        fOverAllSnareSpeed[5];
	local float        fGrowSpeedMultiplier[5];
	local float        fRecedeSpeedMultiplier[5];
	local float        fWiltedTime[5];
	local int          _iTimeSpentWiltedSound[5];

	PlayAnim('grow', 0.0001);

	SetTimer(1.0,true);

	if( !bSlaveSnare )
	{
		if( bRandomizePlants )
		{
			foreach AllActors(class'DevilsSnare', a)
			{
				if( count == 5 )
					break;

				fGrowSpeedMultiplier[count] = a.fGrowSpeedMultiplier;
				fRecedeSpeedMultiplier[count] = a.fRecedeSpeedMultiplier;
				fWiltedTime[count] = a.fWiltedTime;
				fOverAllSnareSpeed[count] = a.fOverAllSnareSpeed;
				_iTimeSpentWiltedSound[count] = a._iTimeSpentWiltedSound;

				do
				{
					i = Rand(5);
				}until( ds[i] == none );
				ds[i] = a;

				count++;
			}

			for( count = 0; count < 5; count++)
			{
				ds[count].fGrowSpeedMultiplier = fGrowSpeedMultiplier[count];
				ds[count].fRecedeSpeedMultiplier = fRecedeSpeedMultiplier[count];
				ds[count].fWiltedTime = fWiltedTime[count];
				ds[count].fOverAllSnareSpeed = fOverAllSnareSpeed[count];
				ds[count]._iTimeSpentWiltedSound = _iTimeSpentWiltedSound[count];
			}
		}
	}
}

//*************************************************************************************************************************
event Timer()
{
	if( !bGrowing )
	{
		PlayAnim('grow', 0.0001);
	}
	else
	{
		if( !bSlaveSnare )
		{
			if( AnimFrame > 0.975 )
			{
				//Harry's Dead
				playerHarry.KillHarry( /*bImmediateDeath*/true );
			}
		}
	}
}

//*************************************************************************************************************************
event Trigger( Actor Other, Pawn EventInstigator )
{
	if( !bSlaveSnare )
	{
		playerHarry.ClientMessage("DevilsSnareEncounter - Trigger");

		//Start Devils snare encounter for harry
		//                               boss, bHarryShouldLockOntoBoss, bReverseInput, bKeepHarryFixed, bCanCast, vFixedFaceDirection, ForceSpellType, bExtendedTargetting);
		playerHarry.StartBossEncounter(  none,                    false,         false,            true,     true,         vect(0,0,0),     SPELL_None,               false);

	}

	PlayAnim('grow', , 30/fTimeLimit);

	bGrowing = true;
}

//***********************************************************************************
function SendDefeatedTrigger()
{
	AnimRate = 0;  //"freeze" it in it's tracks

	if( !bSlaveSnare )
	{
		Super.SendDefeatedTrigger();
	}
}

//***********************************************************************************

defaultproperties
{
     fTimeLimit=30
     bRandomizePlants=True
     CamStateName=Standardstate
     ShadowClass=None
     idleAnimName=None
     Mesh=SkeletalMesh'HPModels.skdeviltimervineMesh'
}
