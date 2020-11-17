class baseVisualEffect expands Effects;
var bool bFollowsOwner;

event Tick(float delta)
{
	if(!bFollowsOwner ||owner==None)
		return;
	SetLocation(owner.location);
}

defaultproperties
{
     bFollowsOwner=True
}
