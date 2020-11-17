class DevilKidHead expands baseChar;

//*************************************************************************************************************************
function HandleIncendioSpell()
{
	SausageRollKidOnAStick(Owner).HandleIncendioSpell();
}

//*************************************************************************************************************************
auto state stateIdle
{
}

defaultproperties
{
     ShadowClass=None
     eVulnerableToSpell=SPELL_Incendio
     DrawType=DT_Mesh
     CollisionRadius=110
     CollisionHeight=80
     bCollideWorld=False
     bBlockActors=False
     bProjTarget=True
}
