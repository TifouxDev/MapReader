module Protocol.MapReader.Element.BasicElement;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Protocol.MapReader.Element.MapElement;
import Protocol.MapReader.Map;
import IO.BinaryReader;
import  Protocol.MapReader.Element.GraphicalElement;
import Protocol.MapReader.Element.SoundElement;

MapElement GetElementFromType(Map map, BinaryReader reader, ubyte type)
{
	switch(type)
	{
		case 2:
			return new GraphicalElement(map,reader);
			break;

		case 33:
			return new SoundElement(map,reader);
			break;
		default:
			break;
	}

	return null;
}
