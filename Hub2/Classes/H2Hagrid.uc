class H2Hagrid extends baseChar;






	var (sales)bool merchant;
	var (sales) int salePrice;
	var (sales) name saleScene;


//function touch( actor other)
function bump(actor other)
{
	
	playerharry.clientMessage("touched");
	if(playerharry==other)
	{
		if(merchant)
		{
			playerharry.clientmessage("merchant");
			if(playerharry.iFireSeedCount>=salePrice)
			{
				TriggerEvent(salescene, self, self);
				playerharry.AddSeeds(-salePrice);
				merchant=false;
				return;
			}
			else
			{
				super.bump(other);
			}

		}
	}

	super.bump(other);

}

defaultproperties
{
     GroundSpeed=150
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhagridMesh'
}
