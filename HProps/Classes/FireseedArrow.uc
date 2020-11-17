//===============================================================================
//  [FireseedArrow] 
//===============================================================================

class FireseedArrow extends HProps;
#exec MESH  MODELIMPORT MESH=FireseedArrowMesh MODELFILE=models\FireseedArrowMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FireseedArrowMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FireseedArrowAnims ANIMFILE=models\FireseedArrowAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FireseedArrowMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FireseedArrowMesh ANIM=FireseedArrowAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FireseedArrowAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FireseedArrowTex0  FILE=TEXTURES\FireseedArrowTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FireseedArrowMesh NUM=0 TEXTURE=FireseedArrowTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: frsedarw_128.bmp  Path: D:\Harry Potter\Art\Objects\Fireseed Challenge

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FireseedArrowMesh'
}
