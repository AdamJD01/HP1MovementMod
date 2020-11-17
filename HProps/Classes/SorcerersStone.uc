//===============================================================================
//  [SorcerersStone] 
//===============================================================================

class SorcerersStone extends HProps;
#exec MESH  MODELIMPORT MESH=SorcerersStoneMesh MODELFILE=models\SorcerersStoneMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SorcerersStoneMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SorcerersStoneAnims ANIMFILE=models\SorcerersStoneAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SorcerersStoneMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SorcerersStoneMesh ANIM=SorcerersStoneAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SorcerersStoneAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SorcerersStoneTex0  FILE=TEXTURES\SorcerersStoneTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SorcerersStoneMesh NUM=0 TEXTURE=SorcerersStoneTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: sorstone_128.bmp  Path: D:\Harry Potter\Art\Objects\Sorcerers Stone 

var vector  vOrigLocation;
var actor   aParticleEffect;

function PostBeginPlay()
{
	vOrigLocation = Location;

	aParticleEffect = spawn(class'SorcererStoneFX');
}

function Tick(float dtime)
{
	SetLocation( vOrigLocation + vec(0, 0, 7.5 * sin( 2 * Level.TimeSeconds )) );
	aParticleEffect.SetLocation( Location );
}

event Destroyed()
{
	local SorcerersStone a;

	//foreach allactors(class'SorcerersStone', a)
	//	Log("*************** Found stone:"$a$" tag:"$a.tag);

	Log("***************** stone get's destroyed");
	aParticleEffect.Destroy();
	//return super.Destroy();
}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.SorcerersStoneMesh'
}
