//===============================================================================
//  [TrollThrowToiletBroken1] 
//===============================================================================

class TrollThrowToiletBroken1 extends TrollThrowbaseFragment;
#exec MESH  MODELIMPORT MESH=TrollThrowToiletBroken1Mesh MODELFILE=models\TrollThrowToiletBroken1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowToiletBroken1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowToiletBroken1Anims ANIMFILE=models\TrollThrowToiletBroken1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowToiletBroken1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowToiletBroken1Mesh ANIM=TrollThrowToiletBroken1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowToiletBroken1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowToiletBroken1Tex0  FILE=TEXTURES\TrollThrowToiletBroken1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowToiletBroken1Mesh NUM=0 TEXTURE=TrollThrowToiletBroken1Tex0

// Original material [0] is [Toilet_skin00] SkinIndex: 0 Bitmap: TrollThrowToilet.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollThrowToiletBroken1Mesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
}
