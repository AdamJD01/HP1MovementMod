//=============================================================================
// InterpolationPoint.
// used to mark bezier spline path for scripted camera sequence (can also be used for other actors)
//=============================================================================
class InterpolationPoint extends Keypoint
	native;

#exec Texture Import File=Textures\IntrpPnt.pcx Name=S_Interp Mips=Off Flags=2

// Number in sequence sharing this tag.
var() int    Position;				// position of this point in the path (specifies order)
var() bool   bEndOfPath;			// if true, stop at this path
var() bool   bInstantNextPath;		// when this path is the next path, move to it instantly, and apply all 0 offset effect instantly
var() bool	 bFaceMoveDirection;	// camera faces movement direction
var   bool   bRollIntoTurn;			// while facing move direction, roll camera based on turn
var   bool	 bSmoothPath;			// true by default - when one control point is adjusted, other is moved to keep tangents the same
var() bool	 bConstantSpeed;		// if true, try to match DesiredVelocity as closesly as possible at all times
var	  bool	 bTurnChange;			// set true if yaw or pitch direction from prev to me is different than from me to next
var() float	 Pause[8];				// pause this length of time at this path
var() name   ViewTargetTag[8];		// tag of actor to focus on	
var() bool   bNewRotationSmoothing;
var   transient actor	 ViewTarget[8];

// smoothly change values either over period of move or during pause
var() float  GameSpeed[8];			// rate of passage of time, smoothly changed
var() float  FovModifier[8];		// modifies player's FOV. Default value is 1
var() float  ScreenFlashScale[8];	// modifies player's screen flash smoothly. Default value is 1
var() vector ScreenFlashFog[8];		// modifies player's screen fog smoothly.  Default value is (0,0,0)
var() name Events[8];				// the event to trigger when the move (if 0) or the pause is completed
var() byte NonLinearEffect[8];		// whether effect should be applied in a non-linear fashion

var InterpolationPoint Prev;		// previous point in this interpolation path.
var InterpolationPoint Next;		// following point in this interpolation path.

var() vector  StartControlPoint;	// control point offset for bezier section am start of
var() vector  EndControlPoint;		// control point offset for bezier section am end of

var() color DistanceFogColor;
var() float DistanceFogStart;
var() float DistanceFogEnd;

var() float Smoothing;			// how much to smooth rotation rate changes occuring at this path
var() float DesiredSpeed;		// if not 0, try to match this velocity.  Try to maintain as average for each spline, or if bConstantSpeed, try to maintain for each tick
var	  float PathDist;			// length of spline path ending at this point (calculated in editor)
//
// At start of gameplay, link all matching interpolation points together.
//
simulated function BeginPlay()
{
	local int i;
	local interpolationpoint current;

	Super.BeginPlay();

	// Try to find next interpolation point.
	foreach AllActors( class 'InterpolationPoint', Current, Tag )
	{
		if ( (Current.Position > Position)
			&& ((Next == None) || (Next.Position > Current.Position)) )
		{
			Next = Current;
			if( Next.Position == Position+1 )
				break;
		}
	}
	
	if( Next == None )
		foreach AllActors( class 'InterpolationPoint', Next, Tag )
			if( Next.Position == 0 )
				break;
	if( Next != None )
		Next.Prev = Self;
	if ( (Events[0] == 'None') || (Events[0] == '') )
		Events[0] = Event;

	if ( bFaceMoveDirection || (ViewTargetTag[0] != 'None')
		|| (Prev == None) || (Next == None) )
		return;
	if ( Next.bFaceMoveDirection || (Next.ViewTargetTag[0] != 'None')
		|| Prev.bFaceMoveDirection || (Prev.ViewTargetTag[0] != 'None') )
		return;

	for ( i=0; i<8; i++ )
	{
		GameSpeed[i] = FMax(GameSpeed[i], 0.2);
	}
	bTurnChange = ( (PlusDir(Next.Rotation.Yaw,Rotation.Yaw) != PlusDir(Rotation.Yaw,Prev.Rotation.Yaw))
					|| (PlusDir(Next.Rotation.Pitch,Rotation.Pitch) != PlusDir(Rotation.Pitch,Prev.Rotation.Pitch)) );
					
}

// returns true if shortest rotation direction is in the positive (clockwise) direction
function bool PlusDir(int A, int B)
{
	A = A & 65535;
	B = B & 65535;

	if ( Abs(A - B) > 32768 )
		return ( A - B < 0 );
	return ( A - B > 0 );
}

//
// When reach an interpolation point.
//
simulated event InterpolateEnd( InterpolationManager Other, bool bForward )
{
	local InterpolationPoint Dest;

	TriggerEvent(Events[Other.PauseNum], self, Other.Owner.Instigator);
	if ( Pause[Other.PauseNum] > 0 )
	{
		Other.SetPause(Pause[Other.PauseNum]);
		Other.PauseNum++;
		Other.SetStartParameters();
		return;
	}
	if( bEndOfPath )
		Other.FinishedInterpolation(self);
	else 
	{
		Other.PauseNum = 0;
		// find next path
		if ( bForward )
			Dest = Next;
		else
			Dest = Prev;
		Other.Dest = Dest;
		if ( Other.Dest == None )
			Other.FinishedInterpolation(self);
		else
		{
			Other.SetStartParameters();
			if ( Dest.bInstantNextPath )
			{
				// move to dest instantly (location and rotation and any other effects)
				Other.InstantMove();
				Dest.InterpolateEnd(Other, bForward);	
			}
		}
	}
}

defaultproperties
{
     bFaceMoveDirection=True
     bSmoothPath=True
     bConstantSpeed=True
     bNewRotationSmoothing=True
     GameSpeed(0)=1
     GameSpeed(1)=1
     GameSpeed(2)=1
     GameSpeed(3)=1
     GameSpeed(4)=1
     GameSpeed(5)=1
     GameSpeed(6)=1
     GameSpeed(7)=1
     FovModifier(0)=1
     FovModifier(1)=1
     FovModifier(2)=1
     FovModifier(3)=1
     FovModifier(4)=1
     FovModifier(5)=1
     FovModifier(6)=1
     FovModifier(7)=1
     ScreenFlashScale(0)=1
     ScreenFlashScale(1)=1
     ScreenFlashScale(2)=1
     ScreenFlashScale(3)=1
     ScreenFlashScale(4)=1
     ScreenFlashScale(5)=1
     ScreenFlashScale(6)=1
     ScreenFlashScale(7)=1
     StartControlPoint=(X=200,Y=200)
     EndControlPoint=(X=-200,Y=-200)
     Smoothing=1
     DesiredSpeed=900
     bDirectional=True
     Texture=Texture'Engine.S_Interp'
}
