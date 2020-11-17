//===============================================================================
//  [GryfCouch] 
//===============================================================================

class GryfCouch extends HProps;
#exec MESH  MODELIMPORT MESH=GryfCouchMesh MODELFILE=models\GryfCouchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GryfCouchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GryfCouchAnims ANIMFILE=models\GryfCouchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GryfCouchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GryfCouchMesh ANIM=GryfCouchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GryfCouchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GryfCouchTex0  FILE=TEXTURES\GryfCouchTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GryfCouchMesh NUM=0 TEXTURE=GryfCouchTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: gryfsofa_128.bmp  Path: H:\Art\Models\Objects\Working\Lorian\Hogwarts\Seventh Floor

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GryfCouchMesh'
     bBlockActors=True
     bBlockPlayers=True
}
