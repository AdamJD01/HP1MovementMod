class cWizCrackerConfetti extends Actor;

struct ConfettiType
{
	var Mesh  _Mesh;
	var float _DrawScale;
};

const NUM_CONFETTI_OPTIONS = 3;
var ConfettiType  ConfettiOptions[3];



//*********************************************************************************************************
function PostBeginPlay()
{
	local float spinRate;
	local int i;

	Super.PostbeginPlay();

	ConfettiOptions[0]._Mesh=Mesh'skGoatMesh';
	ConfettiOptions[0]._DrawScale=0.2;
	ConfettiOptions[1]._Mesh=Mesh'skbarrelMesh';
	ConfettiOptions[1]._DrawScale=0.08;
	ConfettiOptions[2]._Mesh=Mesh'WizCrackerConfettiMesh';   //Keep this as the last one
	ConfettiOptions[2]._DrawScale=2.5;

	i = Rand(1.5 * NUM_CONFETTI_OPTIONS);
	i = Clamp(i, 0, NUM_CONFETTI_OPTIONS - 1 );
	Mesh =      ConfettiOptions[i]._Mesh;
	DrawScale = ConfettiOptions[i]._DrawScale;

	LifeSpan = 3.0 + Frand()*1.5;
	DrawScale *= 0.5+(FRand()*1.0);

	Velocity = VRand();
	Velocity.z = abs( Velocity.z );
	Velocity.z *= 2.0;  //also make it go up more than out
	Velocity *= 500.0 + FRand()*300.0;

	SetCollision(false, false, false);

	spinRate = 60000;
	RotationRate.Yaw = spinRate * 2 *FRand() - spinRate;
	RotationRate.Pitch = spinRate * 2 *FRand() - spinRate;
	RotationRate.Roll = spinRate * 2 *FRand() - spinRate;	
}

//*********************************************************************************************************
event Tick(float dtime)
{
	local float s1, s2;
	local float tv;

	tv = 20;  // "terminal velocity"

	//Uh oh, this might be too slow
	s1 = VSize(Velocity);
	s2 = tv  +  1.0 / (1.0 + 10.0*dtime)  *  (s1 - tv);
	Velocity *= s2/s1;

	SetRotation( Rotation + RotationRate * dtime );
}

//WizCrackerConfettiMesh'

defaultproperties
{
     Physics=PHYS_Falling
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skgoatMesh'
     DrawScale=0.2
}
