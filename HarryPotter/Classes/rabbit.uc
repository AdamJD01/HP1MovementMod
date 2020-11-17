	class rabbit extends baseChar;

	var rotator rotval;

auto state lookcute
{

	begin:
		setPhysics(PHYS_walking);
		rotval=rotation;
		loopanim('idle');

	lcloop:
		sleep(5.0);
		gotostate('hop');



}


state hop
{


function tick(float Deltatime)
{
	local vector offset;




	offset.x=100*deltatime;
	offset=offset>>rotation;
	rotval.yaw=rotval.yaw+(10000*deltatime);
	setrotation(rotval);


	movesmooth(offset);
	super.tick(deltatime);

}

	begin:
		setPhysics(PHYS_walking);
		loopanim('hop');
		
		
	hoploop:
		sleep(5.1);
		gotostate('lookcute');



}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skrabbitMesh'
     CollisionRadius=5
     CollisionHeight=5
}
