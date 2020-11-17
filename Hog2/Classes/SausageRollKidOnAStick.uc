class SausageRollKidOnAStick expands baseChar;

var  bool           bActive;

var  bool           bIsReferee;
var  name           HeadBoneName;
var  DevilKidHead  _DevilKidHead;
var  int           _iCurrentIdleAnim;

//*****************************************************************************************************

function PostBeginPlay()
{
	local SausageRollKidOnAStick     a;

	//If no sausageroll kids have made themselves the ref, make this one be the ref.
	ForEach AllActors(class'SausageRollKidOnAStick', a, tag)
		if( a.bIsReferee == true )
			break;

	//Hey, we're the ref!
	if( a == none )
		bIsReferee = true;

	if( Mesh == mesh'skDevilRonMesh' )
		HeadBoneName = 'Ron';
	else
		HeadBoneName = 'Hermione';

	_DevilKidHead = spawn(class'DevilKidHead', self);
	//_DevilKidHead.AttachToOwner( HeadBoneName );
	//Log("************* bone loc:"$BonePos(HeadBoneName));

	bProjTarget=false;
}

//*****************************************************************************************************
function Tick(float dtime)
{
	local BroomTrail_02 a;
	local vector        v;

	if( _DevilKidHead != none )
	{
		v = BonePos( HeadBoneName );

		//a = spawn(class'BroomTrail_02', [SpawnLocation]v );
		//a.LifeSpan = 1;

		_DevilKidHead.SetLocation( v );
	}
}

//*****************************************************************************************************
function AnimEnd()
{
	local SausageRollKidOnAStick     a;

	if( bActive  &&  _iCurrentIdleAnim == 6 )
	{
		ForEach AllActors(class'SausageRollKidOnAStick', a, tag)
		{
			//If the other one is in anim 6, Harry won
			if( a != self  &&  a._iCurrentIdleAnim == 6 )
			{
				//Send off any triggers.
				a.TriggerEvent( event, a, self );
				TriggerEvent( event, a, self );
				a.bActive = false;
				bActive = false;

				TriggerSnares();
			}
		}
	}
}

//*****************************************************************************************************
function TriggerSnares()
{
	local DevilsSnareNew a;

	ForEach AllActors(class'DevilsSnareNew', a)
		Trigger(self, self);
}

//*****************************************************************************************************
function HandleIncendioSpell()
{
	local sound    snd;

	playerHarry.ClientMessage("sausage hit!");

	if( _iCurrentIdleAnim != 6 )
	{
		switch( Rand(2) )
		{
			case 0:    snd = sound'DS_pod_hit1';    break;
			case 1:    snd = sound'DS_pod_hit2';    break;
		}

		PlaySound( snd, SLOT_none, RandRange(0.95, 1.0), [Pitch]RandRange(0.8, 1.0) );


		_iCurrentIdleAnim++;

		switch( _iCurrentIdleAnim )
		{
			case 2:    LoopAnim( 'Idle2', 1.0, 1.5 );    break;
			case 3:    LoopAnim( 'Idle3', 1.0, 1.5 );    break;
			case 4:    LoopAnim( 'Idle4', 1.0, 1.5 );    break;
			case 5:    LoopAnim( 'Idle5', 1.0, 1.5 );    break;
			case 6:    LoopAnim( 'Idle6', 1.0, 1.5 );    break;
		}

		if( _iCurrentIdleAnim == 6 )
		{
			// AE: releases victim, play long die sound.
			playsound(sound'HPSounds.critters_sfx.DS_Hit_05_Long');
			_DevilKidHead.Destroy();
		}
	}
}

//*****************************************************************************************************
auto state stateIdle
{
  Begin:
	LoopAnim('idle1');
}

//*****************************************************************************************************

defaultproperties
{
     bActive=True
     _iCurrentIdleAnim=1
     ShadowClass=None
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skdevilronMesh'
}
