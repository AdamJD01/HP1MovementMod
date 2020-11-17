class WarnTrigger extends trigger;

var() string WarningMessage;
var() float durration;

var baseHarry playerharry;

function PostBeginPlay()
{
	Super.PostBeginPlay();


	foreach allActors(class'BaseHarry', playerharry)
	{
		break;
	}
}

event Trigger( Actor Other, Pawn EventInstigator )
{
	Touch(other);
}

function Touch( actor Other )
{
local actor A;
local baseHarry h;

	baseHUD(playerharry.myHUD).ShowPopup(class'basewarning');
	basewarning(baseHUD(playerharry.myHUD).curPopup).DisplayText = Localize( "all", WarningMessage,"Pickup" );
	basewarning(baseHUD(playerharry.myHUD).curPopup).lifespan=durration;

	if (bTriggerOnceOnly)
	{
		disable('Touch');
	}

}

defaultproperties
{
     durration=3
}
