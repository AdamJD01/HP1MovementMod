//===============================================================================
//  [TrollThrowToiletBroken2] 
//===============================================================================

class TrollThrowToiletBroken2 extends TrollThrowbaseFragment;
#exec MESH  MODELIMPORT MESH=TrollThrowToiletBroken2Mesh MODELFILE=models\TrollThrowToiletBroken2Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowToiletBroken2Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowToiletBroken2Anims ANIMFILE=models\TrollThrowToiletBroken2Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowToiletBroken2Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowToiletBroken2Mesh ANIM=TrollThrowToiletBroken2Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowToiletBroken2Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowToiletBroken2Tex0  FILE=TEXTURES\TrollThrowToiletBroken2Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowToiletBroken2Mesh NUM=0 TEXTURE=TrollThrowToiletBroken2Tex0

// Original material [0] is [Material2] SkinIndex: 0 Bitmap: TrollThrowToilet.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollThrowToiletBroken2Mesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
