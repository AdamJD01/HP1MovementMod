class cHarryAnimChannel expands AnimChannel;

function GotoStateHoldUpArm()
{
	if( IsInState('stateIdle') )
		GotoState('stateHoldUpArm');
}

function GotoStateIdle()
{
	GotoState('stateIdle');
}

function GotoStateThrow()
{
	GotoState('stateThrow');
}

auto state stateIdle
{
//  Begin:
//	AnimFrame = 0;
}

state stateHoldUpArm
{
  begin:
		//trans2throw
		//throwhold
		//throw
	baseharry(owner).clientmessage("hold up arm");
	PlayAnim( 'trans2throw', 1.0 );
	finishAnim();
	//Sleep(0.1);
	//LoopAnim('throwhold');
  loop:
	Sleep(1);
	Goto 'loop';
}

state stateThrow
{
  begin:
	PlayAnim( 'throw', 1.5 );
	sleep( 0.3375 / 1.5 );
	baseHarry(owner).ThrowCarryingActor();
	finishAnim();

	/*HarryAnimChannel.*/GotoStateIdle();
	baseHarry(Owner).HarryAnimType = AT_Replace;

	//LoopAnim( 'breath' );
	GotoState('stateIdle');
}

defaultproperties
{
}
