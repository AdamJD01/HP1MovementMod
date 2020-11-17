class VenTent2Head expands baseChar;

//*************************************************************************************************************************
function HandleIncendioSpell()
{
	VenomousTent2(Owner).HandleIncendioSpell();
}

//*************************************************************************************************************************
auto state stateIdle
{
}

defaultproperties
{
     ShadowClass=None
     eVulnerableToSpell=SPELL_Incendio
     DrawType=DT_None
     CollisionRadius=20
     CollisionHeight=20
     bCollideWorld=False
     bBlockActors=False
     bProjTarget=True
}
