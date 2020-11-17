//=============================================================================
// ElevatorTrigger.
//=============================================================================
class ElevatorTrigger extends Triggers;

// A special trigger devised for the ElevatorMover class, since
// detecting one trigger message is not enough to determine 2 or more
// different commands (like up/down).  When an actor is within its'
// radius, it sends a message to the ElevatorMover with the desired
// keyframe change and moving time interval.

var() int 	GotoKeyframe;
var() float	MoveTime;

//
// Called when something touches the trigger.
//
function Trigger( actor Other, pawn EventInstigator )
{
	local ElevatorMover EM;
	// Call the ElevatorMover's Move function
	if( Event != '' )
		foreach AllActors( class 'ElevatorMover', EM, Event )
			EM.MoveKeyframe( GotoKeyFrame, MoveTime );
}

defaultproperties
{
}
