class WizardBook extends object;

struct WizardList
{
	var int		ID;
	var bool	bHasCard;
};

var WizardList	Cards[24];

function addcard(int iID)
{
	local int iCard;

	for (iCard = 0; iCard < 24; iCard ++)
	{
		if (Cards[iCard].ID == iID)
		{
			Cards[iCard].bHasCard = true;
			break;
			log("added card " $Cards[iCard].ID);
		}
	}
}

defaultproperties
{
     Cards(0)=(Id=101)
     Cards(1)=(Id=1)
     Cards(2)=(Id=28)
     Cards(3)=(Id=10)
     Cards(4)=(Id=24)
     Cards(5)=(Id=18)
     Cards(6)=(Id=8)
     Cards(7)=(Id=2)
     Cards(8)=(Id=19)
     Cards(9)=(Id=47)
     Cards(10)=(Id=35)
     Cards(11)=(Id=41)
     Cards(12)=(Id=17)
     Cards(13)=(Id=69)
     Cards(14)=(Id=48)
     Cards(15)=(Id=37)
     Cards(16)=(Id=62)
     Cards(17)=(Id=57)
     Cards(18)=(Id=49)
     Cards(19)=(Id=96)
     Cards(20)=(Id=72)
     Cards(21)=(Id=82)
     Cards(22)=(Id=83)
     Cards(23)=(Id=100)
}
