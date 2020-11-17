//===============================================================================
//  [ForbidHallFrames] 
//===============================================================================

class ForbidHallFrames extends HProps;
#exec MESH  MODELIMPORT MESH=ForbidHallFramesMesh MODELFILE=models\ForbidHallFramesMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ForbidHallFramesMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ForbidHallFramesAnims ANIMFILE=models\ForbidHallFramesAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=ForbidHallFramesMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ForbidHallFramesMesh ANIM=ForbidHallFramesAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=ForbidHallFramesAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=ForbidHallFramesTex0  FILE=TEXTURES\ForbidHallFramesTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=ForbidHallFramesMesh NUM=0 TEXTURE=ForbidHallFramesTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: forbidfr_128.bmp  Path: D:\Harry Potter\Art\Objects\Forbidden Corridor\frames

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.ForbidHallFramesMesh'
}
