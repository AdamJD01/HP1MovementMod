class SneakBaseStation extends baseStation;

// Define the Next Patrol Point that the Sneak Actor goes to after Getting here
//	also define what Sneak Actor this Basestation is for
var () name NextPatrolPoint;
var (SneakerCue) name SneakActorName;


// When this basestation is Triggered, it will tell the SneakActor named "SneakActorName"
//	to come to this position, and then he will start his new patrol path.
function Trigger( actor Other, pawn EventInstigator )
{
	local BaseSneakActor SneakActorGuy;

	foreach AllActors(class'BaseSneakActor', SneakActorGuy)
	{
		if(SneakActorGuy.Name == SneakActorName)
			break;
	}

	SneakActorGuy.RunToPredeterminedPoint(self);
}

defaultproperties
{
}
