//=============================================================================
// SpawnThingy.
//=============================================================================
class SpawnThingy expands Triggers;


var() class<Actor> SpawnClass;
var() float			fVelocityModifier;
var() name       SpawnTag;

function Trigger(Actor Other, Pawn Instigator)
{
	local	actor	SpawnedObject;

	local	vector	vel;
	local	rotator	SpawnDirection;

	if (SpawnClass != none)
	{
		if( SpawnTag != '' )
			SpawnedObject = Spawn(SpawnClass,,SpawnTag,Location);
		else
			SpawnedObject = Spawn(SpawnClass,,,Location);

		if (SpawnedObject.isa('jellybean'))
		{
			if (bdirectional)	// only shoot out if the directional flag is set
			{
				// Move the bean out from this object
				vel.x = 96 - 32 + rand(64);
				vel.y = 0;
				vel.z = 40;

				vel = vel >> rotation;
				SpawnedObject.Velocity = vel * fVelocityModifier;
			}
		}
	}
}

defaultproperties
{
     fVelocityModifier=1
     Texture=Texture'HPBase.HPEdit.Icons.SpawnThingy'
}
