// SneakToStationNavPoint - A Special Nav Point that is used by the Sneak Characters to find their way
//	to a BaseStation.

class SneakToStationNavPoint extends NavigationPoint;

var (SneakToStation) name	szSneakBaseStationDest[6];	// This is the final intended Destination
var (SneakToStation) name	szNextPathToBaseStation[6];	// This is the Name of the next SneakToStationNavPoint, 
														//	or the name of the Station if you can get there directly from this point

var int nCounter;	// A class local counter used for iterating through the lists...

// CanGetDirectlyToBaseStationFromHere - This function returns true if an Actor at this
//	NavPoint can simply MoveTo( ) the basestation it is attempting to get to.  Otherwise it returns
//	false and the the Actor should call ReturnNextPathNodeNameForStation( ).
function bool CanGetDirectlyToBaseStationFromHere(name StationName)
{
	for (nCounter=0; nCounter < 6;nCounter++)
	{
		if(StationName == szNextPathToBaseStation[nCounter])  // StationName is in List
			return true;
	}

	return false;	// Station Name wasn't in List
}

// HasPathForBaseStation - this function returns true if a path exists from this NavPoint to the Basestation
//	given by StationName.  If it returns false, there is no path to StationName that can be had by following
//	this NavPoint.
function bool HasPathForBaseStation(name StationName)
{
	local baseHarry playerHarry;

	foreach AllActors(class'baseHarry', playerHarry)
	{
		break;
	}

	for (nCounter=0; nCounter < 6;nCounter++)
	{
		if(StationName == szSneakBaseStationDest[nCounter])  // StationName is in List
		{
			return true;
		}
	}

	return false;	// Station Name wasn't in List
}

// ReturnNextPathNodeNameForStation - Returns the name of the next NavPoint on the route to StationName.  This
//	function shouldn't be called if HasPathForBaseStation( ) returns False, because this function will return
//	an empty Name String.
function name ReturnNextPathNodeNameForStation(name StationName)
{
	for (nCounter=0; nCounter < 6;nCounter++)
	{
		if(StationName == szSneakBaseStationDest[nCounter])  // StationName is in List
		{
			return szNextPathToBaseStation[nCounter];
		}
	}

	return '';	// Station Name wasn't in List
}

defaultproperties
{
}
