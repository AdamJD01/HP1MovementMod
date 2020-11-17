//=============================================================================
// Snitch  -- The little golden flying ball that Harry chases around in Quidditch
//=============================================================================
class Snitch extends QuidditchPawn;

var BroomHoopTrail		HoopTrail;

var(Quidditch) bool		bHasHoopTrail;			// Whether or not snitch has a trail of hoops behind it

var(Quidditch) float	fHoopSpacing;			// Seconds between hoop emissions
var(Quidditch) int		HoopTrailLen;			// How many hoops define touchable portion of trail
var(Quidditch) int		InitialHoopTrailEnd;	// How many hoops back from snitch is the initial end of trail
var(Quidditch) bool		bHoopsVisible;			// Whether or not to display hoops visibly in hoop trail
var(Quidditch) bool		bTrackProgress;			// Whether or not hoop trail tracks player progress


//-------------------------------------------------------------------------------------------
// PostBeginPlay()
//-------------------------------------------------------------------------------------------

function PostBeginPlay()
{
	if ( Mesh == None )
		Mesh = SkeletalMesh'HProps.GoldenSnitchMesh';

	if ( ParticleTrail == None )
		ParticleTrail = class'Snitch_FX';

	// Overrided editor settings (hopefully temp)
	bHasHoopTrail=true;
	fHoopSpacing=1.5;
	HoopTrailLen=2;
	InitialHoopTrailEnd=0;
	bHoopsVisible=true;

	Super.PostBeginPlay();

	if ( bHasHoopTrail )
	{
		HoopTrail = Spawn( class'BroomHoopTrail', , 'HoopTrail', , );
		HoopTrail.Emitter = Self;
		HoopTrail.SetTrailProperties( fHoopSpacing, HoopTrailLen, InitialHoopTrailEnd,
									  bHoopsVisible, bTrackProgress );
		HoopTrail.GotoState( 'TrailOn' );
	}
	else
		HoopTrail = None;

	LoopAnim( 'Flap' );
}


function Hide()
{
	Super.Hide();

	if ( HoopTrail != None )
		HoopTrail.GotoState( 'TrailOff' );
}

function Show()
{
	Super.Show();

	if ( HoopTrail != None )
		HoopTrail.GotoState( 'TrailOn' );
}

defaultproperties
{
     bHasHoopTrail=True
     fHoopSpacing=1.5
     HoopTrailLen=2
     bHoopsVisible=True
     Path(0)='
     fSpeedChangeFactor=0.8
     fSpeedChangeFirstTime=240
     MaxSpeedChanges=3
     ParticleTrail=Class'HPParticle.Snitch_FX'
     HaloClass=Class'HPParticle.Snitch_Halo'
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.sksnitchMesh'
     CollisionRadius=200
     CollisionHeight=200
}
