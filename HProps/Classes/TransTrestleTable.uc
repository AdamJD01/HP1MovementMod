//===============================================================================
//  [TransTrestleTable] 
//===============================================================================

class TransTrestleTable extends HProps;
#exec MESH  MODELIMPORT MESH=TransTrestleTableMesh MODELFILE=models\TransTrestleTableMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TransTrestleTableMesh X=0 Y=0 Z=25 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TransTrestleTableAnims ANIMFILE=models\TransTrestleTableAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TransTrestleTableMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TransTrestleTableMesh ANIM=TransTrestleTableAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TransTrestleTableAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TransTrestleTableTex0  FILE=TEXTURES\TransTrestleTableTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TransTrestleTableMesh NUM=0 TEXTURE=TransTrestleTableTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: SideTable_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Transfigurations Class

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TransTrestleTableMesh'
}
