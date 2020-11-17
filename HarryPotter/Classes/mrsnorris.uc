	class mrsnorris extends baseChar;

	var rotator rotval;
	var vector facedir;
	var vector offset;
	var int failcount;
	var float walktime;
	var  actor teather; 
	var (ai) float leashLength;
	var (ai) name teatherName;




function targeted()
{
	p.clientmessage("targeted");
	gotostate('hiss');
}



state hiss
{
function targeted()
{

}
	begin:

	playanim('hiss');
//	PlaySound(sound 'HPSounds.Critters_sfx.nor_cat_hiss', SLOT_Interact, 1.0, false, 1000.0, 1.0);

	turntoward(p);
	finishanim();

		offset=vrand();			
		offset.z=0;
		failcount=0;
		walktime=5;
		while(!fastTrace((normal(offset)*400)+location)&&failcount<4)
		{
			
			offset=vrand();			
			offset.z=0;
			failcount++;
			walktime=2;

		}
		facedir=((offset*1000000)+location);	


	lcloop:
		
		gotostate('run');
}



auto state lookcute
{


	function startup()
	{
		local actor testteather;

		foreach allActors(class'baseHarry', p)
		{
			if( p.bIsPlayer&& p!=Self)
			{
		
				break;
			}
		}

		teather=none;
		foreach allActors(class 'actor',testteather)
		{
			if(testteather.Name==teatherName)
			{
				
				teather=testteather;
				break;
			}
		}

		

	}


	begin:
		setPhysics(PHYS_walking);
		startup();
		rotval=rotation;
		switch(rand(2))
		{
			case 0:
				playanim('look');
				break;
			case 1:
				playanim('stand2sit');
				finishanim();
				playanim('licksit');
				finishanim();
				playanim('sit2stand');
				break;
		}
		finishanim();
		if(teather!=none)
		{
			if(abs(vsize(location-teather.location))<leashlength)
			{
			
				offset=normal(teather.location-location);
			}
			else
			{
				offset=vrand();	
			}
		}
		else
		{
			offset=vrand();	
		}

				
		offset.z=0;
		failcount=0;
		walktime=5;
		while(!fastTrace((normal(offset)*400)+location)&&failcount<4)
		{
			
			offset=vrand();			
			offset.z=0;
			failcount++;
			walktime=2;

		}
		facedir=((offset*1000000)+location);	


	lcloop:
		
		gotostate('walk');



}


state walk
{
ignores SeePlayer;




simulated function HitWall( vector HitNormal, actor HitWall )
{

	gotostate('lookcute');
	


}


function touch (actor other)
{

	gotostate('lookcute');
}

function timer()
{
	gotostate('lookcute');
}

function tick(float Deltatime)
{
	


//	super.tick(deltatime);





	movesmooth(normal(offset)*(deltatime*50));


}

	begin:
		enable ('hitwall');
		loopanim('walk');
		settimer(5,false);
		
		
	moveloop:	
		sleep(0.11);
		turnto(facedir);
		goto 'moveloop';




}



state run
{
ignores SeePlayer;

function targeted()
{

}



simulated function HitWall( vector HitNormal, actor HitWall )
{

	gotostate('lookcute');
	


}

function touch (actor other)
{

	gotostate('lookcute');
}

function timer()
{
	gotostate('lookcute');
}

function tick(float Deltatime)
{
	


//	super.tick(deltatime);





	movesmooth(normal(offset)*(deltatime*100));


}

	begin:
		enable ('hitwall');
		loopanim('run');
		settimer(5,false);
		
		
	moveloop:	
		sleep(0.11);
		turnto(facedir);
		goto 'moveloop';




}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skmrsnorrisMesh'
     CollisionRadius=30
     CollisionHeight=30
     bProjTarget=True
}
