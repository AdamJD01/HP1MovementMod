//===============================================================================
//  [FloatingSpellBook] 
//===============================================================================

class FloatingSpellBook extends HProps;
#exec MESH  MODELIMPORT MESH=FloatingSpellBookMesh MODELFILE=models\FloatingSpellBookMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FloatingSpellBookMesh X=0 Y=0 Z=16 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FloatingSpellBookAnims ANIMFILE=models\FloatingSpellBookAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FloatingSpellBookMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FloatingSpellBookMesh ANIM=FloatingSpellBookAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FloatingSpellBookAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FloatingSpellBookTex0  FILE=TEXTURES\FloatingSpellBookTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FloatingSpellBookMesh NUM=0 TEXTURE=FloatingSpellBookTex0


// Original material [0] is [Material #8] SkinIndex: 0 Bitmap: floatbok_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects\books 

var() Class<baseSpell> spellType;

function touch (actor other)
{
	if(other==playerharry)
	{
		PlaySound(sound'HPSounds.magic_sfx.s_spell_avif_throw');

		baseWand(playerharry.weapon).addSpell(spellType);
		switch(spellType)
			{
			case Class'spellAloho':
				hpHud(playerharry.myhud).ShowPopup(class'alohPage');
			//	PlaySound(sound'HPSounds.dlg_har.Har_021');
				break;
			case Class'spellAvif':
				hpHud(playerharry.myhud).ShowPopup(class'avifPage');
				break;
			case Class'spellFlint':
				hpHud(playerharry.myhud).ShowPopup(class'flintPage');
				break;
			case Class'spellVerd':
				hpHud(playerharry.myhud).ShowPopup(class'verdPage');
				break;
			case Class'spellLev':
				hpHud(playerharry.myhud).ShowPopup(class'wingPage');
				break;
			case Class'spellFlip':
				hpHud(playerharry.myhud).ShowPopup(class'wingPage');
				break;
			case Class'spellRepairo':
				hpHud(playerharry.myhud).ShowPopup(class'wingPage');
				break;
			}


//		hpHud(playerharry.myhud).numFrogs=hphud(playerharry.myhud).numFrogs+1;
		destroy();
	}


}

defaultproperties
{
     bDoBob=True
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FloatingSpellBookMesh'
}
