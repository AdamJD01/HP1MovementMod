// Invisiblity Cloak - Picked up by Harry during the sneak levels to make him invisible...
// author:  Paul J. Furio


class InvisibilityCloak extends HProps;

var actor cloakparticle;


function PreBeginPlay()
{
	Super.PreBeginPlay();

	cloakparticle=spawn(class'jellyglow');
	enable('Touch');
}


function touch (actor other)
{
	local InvisibleHarry	InvisHarry;

	if(other==playerharry)
	{
		disable('Touch');

		foreach allActors(class'InvisibleHarry', InvisHarry)
		{
			if( InvisHarry.bIsPlayer&& InvisHarry!=Self)
			{
				InvisHarry.bHasCloak = true;
				break;
			}
		}

		gotostate('killcloak');
	}
}


state killcloak
{
begin:

	cloakparticle.destroy();
	cloakparticle=spawn(class'jellybean_pickup');
	destroy();

loop:
	sleep(1);
	goto 'loop';
}

defaultproperties
{
     bStatic=False
     Physics=PHYS_Walking
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.JellybeanMesh'
     AmbientGlow=200
}
