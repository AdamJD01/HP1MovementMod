class cHarryAnimChannel expands AnimChannel;

//Edited by- AdamJD (edited code will have AdamJD by it)

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

//AdamJD
function GotoStateCasting()
{
	GotoState('stateCasting');
}

//AdamJD
function GotoStateCancelCasting()
{
	GotoState('stateCancelCasting');
}

//AdamJD
function GotoStateCast()
{
	GotoState('stateCast');
}

//AdamJD
function GotoStateHasCast()
{
	GotoState('stateHasCast');
}

//go to baseHarry class to get cast function -AdamJD
function Cast()
{
	local baseHarry harry;
	ForEach AllActors (class'baseHarry', harry)
	harry.Cast();
}

auto state stateIdle
{
 // Begin:
	// AnimFrame = 0;
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

	/*HarryAnimChannel.*/ //GotoStateIdle(); //not needed -AdamJD
	baseHarry(Owner).HarryAnimType = AT_Replace;
	baseHarry(owner).PlayFinishThrowCrackerAnim(); //this fixes the issue where Harry kept his arms held up after throwing a cracker -AdamJD

	//LoopAnim( 'breath' );
	// GotoState('stateIdle'); //not needed -AdamJD
}

//AdamJD
state stateCasting
{
	//move camera when casting and turn spell casting stuff on -AdamJD
	function BeginState()
	{
		local baseHarry harry;
		ForEach AllActors (class'baseHarry', harry)
		harry.HarryAnimType = AT_Combine;
		harry.StartCasting();
	}
	
	begin:
	  LoopAnim('wave', 1.0, 0.2); 
}

//AdamJD
state stateCancelCasting
{
	//turn spell casting stuff off -AdamJD
	function BeginState()
	{
		local baseHarry harry;
		ForEach AllActors (class'baseHarry', harry)
		harry.HarryAnimType = AT_Combine;
		harry.StopCasting();
	}
	
  begin:
	PlayAnim('cast', 2.0 , 0.1); //setting the anim to 'breath' messes up the walking animations so 'cast' will have to do... -AdamJD
	FinishAnim(); //stops Harry snapping his arm back too early -AdamJD
	baseHarry(owner).HarryAnimType = AT_Replace;
	baseHarry(owner).PlayFinishCastAnim();
}

//AdamJD
state stateCast
{
	//turn spell casting stuff off -AdamJD
	function BeginState()
	{
		local baseHarry harry;
		ForEach AllActors (class'baseHarry', harry)
		harry.HarryAnimType = AT_Combine;
  		// PlayAnim('cast', 2.0, 0.1);
		harry.StopCasting();
	}
	
  begin:
	PlayAnim('cast', 2.0, 0.1);
	// FinishAnim(); 
	baseHarry(owner).HarryAnimType = AT_Replace;
	baseHarry(owner).PlayFinishCastAnim();
} 

//AdamJD
state stateHasCast
{
	//turn spell casting stuff off -AdamJD
	function BeginState()
	{
		local baseHarry harry;
		ForEach AllActors (class'baseHarry', harry)
		harry.HarryAnimType = AT_Combine;
		harry.StopCasting();
	}
	
  begin:
	FinishAnim(); //stops Harry snapping his arm back too early -AdamJD
	baseHarry(owner).HarryAnimType = AT_Replace;
	baseHarry(owner).PlayFinishCastAnim();
}

defaultproperties
{
}
