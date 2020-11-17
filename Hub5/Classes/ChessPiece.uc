class ChessPiece extends baseChar;

var vector		ChessTargetLocation;
var bool		bMoved;

var float		fCombatTime;
var float		fOldTime;
var bool		bPieceWhite;

var ChessTrail	Trail;

var()	sound	AttackSound;

//AE:
function PlayAttackSound()
{
	switch( Rand(19) )
	{
		case 0:		PlaySound(sound'HPSounds.hub5_sfx.sword1');				break;
		case 1:		PlaySound(sound'HPSounds.hub5_sfx.sword2');				break;
		case 2:		PlaySound(sound'HPSounds.hub5_sfx.sword3');				break;
		case 3:		PlaySound(sound'HPSounds.hub5_sfx.sword4');				break;
		case 4:		PlaySound(sound'HPSounds.hub5_sfx.sword5');				break;
		case 5:		PlaySound(sound'HPSounds.hub5_sfx.sword6');				break;
		case 6:		PlaySound(sound'HPSounds.hub5_sfx.sword7');				break;
		case 7:		PlaySound(sound'HPSounds.hub5_sfx.sword8');				break;
		case 8:		PlaySound(sound'HPSounds.hub5_sfx.sword9');				break;
		case 9:		PlaySound(sound'HPSounds.hub5_sfx.sword10');			break;
		case 10:	PlaySound(sound'HPSounds.hub5_sfx.sword11');			break;
		case 11:	PlaySound(sound'HPSounds.hub5_sfx.sword12');			break;
		case 12:	PlaySound(sound'HPSounds.hub5_sfx.sword13');			break;

		case 13:	PlaySound(sound'HPSounds.hub5_sfx.swordswipe1');		break;
		case 14:	PlaySound(sound'HPSounds.hub5_sfx.swordswipe2');		break;
		case 15:	PlaySound(sound'HPSounds.hub5_sfx.swordswipe3');		break;
		case 16:	PlaySound(sound'HPSounds.hub5_sfx.swordswipe4');		break;
		case 17:	PlaySound(sound'HPSounds.hub5_sfx.swordswipe5');		break;
		case 18:	PlaySound(sound'HPSounds.hub5_sfx.swordswipe6');		break;
	}
}

function explode()
{
	local ChessExplo	ExplosionFX;

	PlaySound(sound'HPSounds.hub5_sfx.chess_piece_explode');
	ExplosionFX = spawn(class'ChessExplo', [spawnlocation] location);

	if (bPieceWhite)
	{
		explodeWhite();
	}
	else
	{
		explodeBlack();
	}
	Destroy();
}

function explodeWhite()
{
	local HProps	Fragment;
	local vector	startpoint;

	startpoint = location + vec(0, 0, 50);

	Velocity *= 0.5;

	Fragment = spawn(class'ChessWhiteChunk1', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);
	
	Fragment = spawn(class'ChessWhiteChunk2', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);

	Fragment = spawn(class'ChessWhiteChunk3', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);

	Fragment = spawn(class'ChessWhiteChunk1', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);
	
	Fragment = spawn(class'ChessWhiteChunk2', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);

	Fragment = spawn(class'ChessWhiteChunk3', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);
}

function explodeBlack()
{
	local HProps	Fragment;
	local vector	startpoint;

	startpoint = location + vec(0, 0, 50);

	Velocity *= 0.5;

	Fragment = spawn(class'ChessBlackChunk1', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);
	
	Fragment = spawn(class'ChessBlackChunk2', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);

	Fragment = spawn(class'ChessBlackChunk3', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);

	Fragment = spawn(class'ChessBlackChunk1', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);
	
	Fragment = spawn(class'ChessBlackChunk2', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);

	Fragment = spawn(class'ChessBlackChunk3', [spawnlocation] startpoint);
	Fragment.SetPhysics(Phys_falling);
	Fragment.velocity = vec(rand(400) - 200, rand(400) - 200, rand(200) + 50);
}

auto state idle
{
	function beginstate()
	{
		playanim('gesture_left');
	}

	function AnimEnd()
	{
		if (rand(2) == 0)
		{
			playanim('gesture_right');
		}
		else
		{
			playanim('gesture_left');
		}
	}
}

state PieceMoving
{
begin:
	loopanim('advance');
	PlaySound(sound'HPSounds.hub5_sfx.chess_piece_move');
	Trail = spawn(class'ChessTrail', [spawnlocation] location);
	Trail.SetPhysics(PHYS_Trailer);
	Trail.setowner(self);
	Trail.AttachToOwner();

loop:
	if (ChessTargetLocation != vect(0, 0, 0))
	{
		moveto(ChessTargetLocation);
		log("Piece velocity " $vsize(velocity));
		if (vsize(velocity) == 0)
		{
			bMoved = true;
			ChessTargetLocation = vect(0, 0, 0);
			Trail.Shutdown();
			gotostate('idle');
		}
	}
	sleep(0.1);

	goto 'loop';
}

state PieceAttacking
{

	function Tick(float deltatime)
	{
		fCombatTime += deltatime;
		if (fCombatTime > fOldtime + 0.75)
		{
			//AE:
			//PlaySound(AttackSound);
			PlayAttackSound();

			fOldTime = fCombatTime;
		}
	}

begin:
	loopanim('Attack');
	fCombatTime = 0;		// So it automatically ends if no combat
	fOldtime = 0;

loop:
	if (ChessTargetLocation != vect(0, 0, 0))
	{
		moveto(ChessTargetLocation);
		log("Piece velocity " $vsize(velocity));
		if (vsize(velocity) == 0 && fCombatTime > 4)
		{
			bMoved = true;
			ChessTargetLocation = vect(0, 0, 0);
			gotostate('idle');
		}
	}
	sleep(0.1);

	goto 'loop';
}

state PieceDefending
{
	function Tick(float deltatime)
	{
		fCombatTime += deltatime;
		if (fCombatTime > fOldtime + 1)
		{
			// AE:
			//PlaySound(AttackSound);
			PlayAttackSound();

			fOldTime = fCombatTime;
		}
	}

begin:
	loopanim('Attack');
	fCombatTime = 0;
	fOldtime = 0;
loop:
	sleep(0.1);

	goto 'loop';
}

defaultproperties
{
     MaxDesiredSpeed=100
     GroundSpeed=100
     Physics=PHYS_Walking
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.skmountaintrollMesh'
}
