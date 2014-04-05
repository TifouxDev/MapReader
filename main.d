module main;
/*  /////////////////////
 *   MapReader by tifoux
 *  ------Exemple d'utilisation!------
 */////////////////////

import std.stdio;
import Utils.Logger;
import Protocol.Core.PakProtocol2;
import Protocol.MapReader.Map;
import std.conv;
import Protocol.MapReader.CellData;
void main(string[] args)
{
	setTitle((cast(char*)"Dofus Data Reader"));
	/*Chemin de votre fichier d2p 
	 * Example : C:\\Program Files (x86)\\Dofus2\\app\\content\\maps\\maps0.d2p
	*/
	string path = "C:\\Users\\Ecole Eletronique\\Music\\WakfuSniffer\\maps0.d2p";
	// L'ID de la map!
	int mapID = 84676099;
	PakProtocol2 d2pTest = new PakProtocol2(path);
	Map map = d2pTest.readMap(mapID);
	//test
	int cellID = 0;
	foreach(CellData cell; map.Cells)
	{
		if((cell.Mov))
			logError("CellID -> "~to!string(cell.CellID)~" Non marchable");
		else
			logDebug("CellID -> "~to!string(cell.CellID)~" Marchable");
	}

	stdin.readln();
}

