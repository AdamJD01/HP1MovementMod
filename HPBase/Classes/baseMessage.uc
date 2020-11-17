class baseMessage expands LocalMessage;

static simulated function ClientReceive( 
	PlayerPawn P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

//	P.ClientPlaySound(sound'Announcer.HeadShot',, true);
}

static function string GetString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1, 
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
//	return Class<baseProps>(OptionalObject).Default.sProxMessage;
}

defaultproperties
{
     bIsSpecial=True
     bIsUnique=True
     bFadeMessage=True
}
