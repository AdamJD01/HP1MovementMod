//===============================================================================
//  [HagridSaw] 
//===============================================================================

class HagridSaw extends HProps;
#exec MESH  MODELIMPORT MESH=HagridSawMesh MODELFILE=models\HagridSawMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HagridSawMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridSawAnims ANIMFILE=models\HagridSawAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HagridSawMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridSawMesh ANIM=HagridSawAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridSawAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HagridSawTex0  FILE=TEXTURES\HagridSawTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HagridSawMesh NUM=0 TEXTURE=HagridSawTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: hagrdsaw_128.bmp  Path: D:\Harry Potter\Art\Objects\Hagrids Hut\saw

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HagridSawMesh'
}
