class Hub5Column extends Column;


//********************************************************************
function DestroyColumn()
{
	local BossQuirrel  a;

	//Tell Boss that we've been destroyed
	foreach AllActors(class'BossQuirrel', a)
		a.TriggerSpecial(self, 0);

	super.DestroyColumn();
}

defaultproperties
{
}
