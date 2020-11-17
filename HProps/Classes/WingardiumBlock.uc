//===============================================================================
//  [WingardiumBlock] 
//===============================================================================

class WingardiumBlock extends HProps;
#exec MESH  MODELIMPORT MESH=WingardiumBlockMesh MODELFILE=models\WingardiumBlockMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WingardiumBlockMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WingardiumBlockAnims ANIMFILE=models\WingardiumBlockAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WingardiumBlockMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WingardiumBlockMesh ANIM=WingardiumBlockAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WingardiumBlockAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WingardiumBlockTex0  FILE=TEXTURES\WingardiumBlockTex0.bmp  GROUP=Skins
#EXEC TEXTURE IMPORT NAME=WingardiumBlockTex1  FILE=TEXTURES\WingardiumBlockTex1.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WingardiumBlockMesh NUM=0 TEXTURE=WingardiumBlockTex0
#EXEC MESHMAP SETTEXTURE MESHMAP=WingardiumBlockMesh NUM=1 TEXTURE=WingardiumBlockTex1

// Original material [0] is [owlblockcap_skin00] SkinIndex: 0 Bitmap: owlblockcaps_skin01.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
// Original material [1] is [owlblock_skin01] SkinIndex: 1 Bitmap: owlblock_skin00.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 
var bool landed;

auto state wing
{

// AE: Override this function so that we can play a thumping sound when the block hits
// the ground or whatever it's landing on.

	function Landed(vector HitNormall)
	{
		// Trigger landing audio event.
		switch( Rand(3) )
		{
			case 0: PlaySound(sound'HpSounds.Hub1_sfx.Block_stop1');
				break;

			case 1: PlaySound(sound'HpSounds.Hub1_sfx.Block_stop2');
				break;
		
			case 2: PlaySound(sound'HpSounds.Hub1_sfx.Block_stop3');
				break;
		}

		if( bWasCarried && !SetLocation(Location) )
		{
			if( Instigator!=None && (VSize(Instigator.Location - Location) < CollisionRadius + Instigator.CollisionRadius) )
			SetLocation(Instigator.Location);
			TakeDamage( 1000, Instigator, Location,
			Vect(0,0,1)*900,'exploded' );
		}
		bWasCarried = false;
		bBobbing = false;
	}

	singular function BaseChange()
	{
		local float decorMass, decorMass2;

		decormass= FMax(1, Mass);
		bBobbing = false;

		if( (base == None) && (bPushable || IsA('Carcass')) && (Physics == PHYS_None) )
			SetPhysics(PHYS_Falling);
		else if( (Pawn(base) != None) )
		{
		//	Base.TakeDamage( (1-Velocity.Z/400)* decormass/Base.Mass,Instigator,Location,0.5 * Velocity , 'crushed');
			Velocity.Z = 00;
			if (FRand() < 0.5)
				Velocity.X += 70;
			else
				Velocity.Y += 70;
			setlocation(location+velocity);
			SetPhysics(PHYS_Falling);

		}
		else if( Decoration(Base)!=None && Velocity.Z<-500 )
		{
			decorMass2 = FMax(Decoration(Base).Mass, 1);
			
		//	Base.TakeDamage((1 - decorMass/decorMass2 * Velocity.Z/30), Instigator, Location, 0.2 * Velocity, 'stomped');
			Velocity.Z = 100;
			if (FRand() < 0.5)
				Velocity.X += 70;
			else
				Velocity.Y += 70;
			SetPhysics(PHYS_Falling);
		}
		else
			instigator = None;
	}

	begin:
		if((location.z-orgloc.z)<-100)
		{
			setlocation(orgloc);
			spawn(class'Spawn_flash_2',,,,rot(0,0,0));
		}
		sleep(0.5);
		
	
	//	if(!bIsLevitating)
		if(touchingAct!=None)
		{
			if(touchingAct.isa('trigger'))
			{
				if(self.class==trigger(touchingAct).ClassProximityType)
				{
					bIsLevitating=false;
					if(bprojtarget)
					{
						setlocation(touchingAct.location);
						setPhysics(PHYS_FALLING);
						bprojtarget=false;
					}
				}
			
			}
		}

		goto 'begin';
}

defaultproperties
{
     bCanLevitate=True
     ShadowClass=Class'HProps.BlockShadow'
     bSlick=True
     bStatic=False
     eVulnerableToSpell=SPELL_WingardiumLeviosa
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WingardiumBlockMesh'
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bProjTarget=True
}
