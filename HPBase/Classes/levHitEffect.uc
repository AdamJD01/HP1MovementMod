//===============================================================================
//  [levhiteffect] 
//===============================================================================

class levhiteffect extends basevisualeffect;
#exec MESH  MODELIMPORT MESH=levhiteffectMesh MODELFILE=models\levhiteffect.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=levhiteffectMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=levhiteffectAnims ANIMFILE=models\levhiteffect.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=levhiteffectMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=levhiteffectMesh ANIM=levhiteffectAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=levhiteffectAnims VERBOSE

#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage
 


//#EXEC TEXTURE IMPORT NAME=levhiteffectTex0  FILE=TEXTURES\win_L.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=levhiteffectMesh NUM=0 TEXTURE=HPBase.FXPackage.win_l

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: Lev.bmp  Path: C:\HarryPotter\FX 


function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('all', 0.5, 0.0);
}

defaultproperties
{
     DrawType=DT_Mesh
     Style=STY_Translucent
     Mesh=SkeletalMesh'HPBase.levhiteffectMesh'
}
