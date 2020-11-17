class DevilsSnareHead expands baseChar;

//*************************************************************************************************************************
function HandleIncendioSpell()
{
	DevilsSnareNew(Owner).HandleIncendioSpell();
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
     CollisionRadius=60
     CollisionHeight=40
     bCollideWorld=False
     bBlockActors=False
     bBlockPlayers=False
     bProjTarget=True
}
