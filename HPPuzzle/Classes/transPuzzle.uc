class transPuzzle expands basePuzzle;

var (Puzzle) int count;

function Reward()
{
local playerPawn harry;


	foreach allActors(class'playerPawn', harry)
		{
		baseHud(harry.myHud).ShowPopup(class'congratsLetter');
		}

	
}
function Trigger( actor Other, pawn EventInstigator )
//function myTrigger(baseProps item)
{

local playerPawn harry;


		count--;
		if(count==0)
			{
		//	Reward();
		foreach allActors(class'playerPawn', harry)
			{
			HPHud(harry.myHud).Stopcountdown();
			}


			gotostate('setReward');
			}

			
}


function timer()
{
local playerPawn harry;


	foreach allActors(class'playerPawn', harry)
	{
		baseHud(harry.myHud).ShowPopup(class'sorryLetter');
		destroy();
			
	}


}


state setReward
{
	begin:
	sleep(4);
	reward();
	loop:
	sleep(1);
	goto 'loop';


}

defaultproperties
{
     Count=4
}
