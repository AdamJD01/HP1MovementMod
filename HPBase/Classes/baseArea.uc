class baseArea extends Actor;

var  enum eAreaType
{
	AREA_None,
	AREA_Hidden,
	AREA_Noisy
}AreaType;

function eAreaType actorInBox( actor other)
{

	local float min;
	local float max;
	local PlayerPawn p;



	// check x first
	min=location.x-CollisionWidth/2;
	max=location.x+CollisionWidth/2;
	if((other.location.x>= min)&&(other.location.x<=max))
	{
		p=PlayerPawn(other);
	
		//now check y

		min=location.y-CollisionRadius/2;
		max=location.y+CollisionRadius/2;
		if((other.location.y>= min)&&(other.location.y<=max))
		{
		
			min=location.z-CollisionHeight;
			max=location.z+CollisionHeight;
			if((other.location.z>= min)&&(other.location.z<=max))
			{
				
				return AreaType;
			}

		}

	}





	return AREA_None;



}

defaultproperties
{
     bHidden=True
     CollisionRadius=100
     CollisionWidth=100
     CollideType=CT_Box
}
