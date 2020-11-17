	class hagrid extends baseChar;



	var int dialog1[20];
	var int currentspeech;
	var vernon vern;



auto state wait
{

	begin:
	

		sleep (1.0);
		goto 'begin';


}

state converse
{


function Tick(float DeltaTime)
{

}

	function startup()
	{
		
		foreach allActors(class'baseHarry', p)
		{
			if( p.bIsPlayer&& p!=Self)
			{
		
				break;
			}
		}

		foreach allActors(class'Vernon',vern)
		{

			break;

		}
	}


 function playSpeech(int dia[20])
	{
		local sound step;
		local int whichSp;

		whichSp=dia[currentspeech];
		step=speech[whichSp];
		PlaySound(step, SLOT_talk,1.0, false, 1000.0, 0.9);
		currentSpeech=currentSpeech+1;
	}



	begin:
		
		loopanim('breath');
		startup();
		moveto(forcelocation);

		currentspeech=0;


	loop:
		//turnto(forcedir);
		

		Level.Game.RestartGame();

		goto 'loop';


}

defaultproperties
{
     dialog1(0)=4
     dialog1(1)=1
     dialog1(2)=5
     dialog1(3)=2
     dialog1(4)=6
     dialog1(5)=1
     dialog1(6)=3
     dialog1(7)=4
     dialog1(8)=2
     dialog1(9)=5
     dialog1(10)=7
     dialog1(11)=6
     dialog1(12)=3
     dialog1(13)=7
     dialog1(14)=-1
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skhagridMesh'
}
