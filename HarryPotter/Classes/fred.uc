	class fred extends baseChar;


	var (sales)bool merchant;
	var (sales) int salePrice;
	var (sales) name saleScene;


//function touch( actor other)
function bump(actor other)
{
	if(other==playerharry)
	{
		
		if(merchant)
		{
			playerharry.clientmessage("merchant");
			if(playerharry.numBeans>=salePrice)
			{
			//warning following line is massive kludge and may cause cancer gk 9/3/01
				basehud(playerharry.myhud).bcutsceneMode=true;
			
				TriggerEvent(salescene, self, self);
				playerHarry.AddBeans(-salePrice);
				merchant=false;
				return;
			}

		}
	}
	
	super.bump(other);

}

defaultproperties
{
     GroundSpeed=150
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skfredMesh'
}
