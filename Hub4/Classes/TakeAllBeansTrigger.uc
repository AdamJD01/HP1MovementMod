//=============================================================================
// TakeAllBeansTrigger.
//=============================================================================
class TakeAllBeansTrigger expands Trigger;

event Trigger( Actor Other, Pawn EventInstigator )
{
	local baseHarry a;
	foreach allactors(class'baseHarry',a)
	{
		a.numBeans = a.numBeans - 25;
		if(a.numBeans < 0)
			a.numBeans = 0;
	log("**************** beans"$a.numBeans);
	}
}

defaultproperties
{
}
