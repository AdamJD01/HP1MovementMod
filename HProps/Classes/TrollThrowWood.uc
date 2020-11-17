//===============================================================================
//  [TrollThrowWood] 
//===============================================================================

class TrollThrowWood extends BaseToiletObject;
#exec MESH  MODELIMPORT MESH=TrollThrowWoodMesh MODELFILE=models\TrollThrowWoodMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=TrollThrowWoodMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=TrollThrowWoodAnims ANIMFILE=models\TrollThrowWoodAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=TrollThrowWoodMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=TrollThrowWoodMesh ANIM=TrollThrowWoodAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=TrollThrowWoodAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=TrollThrowWoodTex0  FILE=TEXTURES\TrollThrowWoodTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=TrollThrowWoodMesh NUM=0 TEXTURE=TrollThrowWoodTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: Trolwood_128.bmp  Path: D:\Harry Potter\Art\Objects\Troll Throwing Objects\Wood Wall 

function explode(vector HitNormal)
{
	local HProps	Fragment;

	ExplosionFX = spawn(class'ChessExplo', [spawnlocation] location);

	Velocity *= 0.5;

	Fragment = spawn(class'TrollThrowWoodBit', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));
	
	Fragment = spawn(class'TrollThrowWoodBit', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	Fragment = spawn(class'TrollThrowWoodBit', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	Fragment = spawn(class'TrollThrowWoodBit', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));
	
	Fragment = spawn(class'TrollThrowWoodBit', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	Fragment = spawn(class'TrollThrowWoodBit', [spawnlocation] location);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = MirrorVectorByNormal(Velocity, HitNormal);
	Fragment.velocity += vec(RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangexy,RandRangexy),RandRange(-RandRangez,RandRangez));

	destroy();
}

defaultproperties
{
     Mesh=SkeletalMesh'HProps.TrollThrowWoodMesh'
}
