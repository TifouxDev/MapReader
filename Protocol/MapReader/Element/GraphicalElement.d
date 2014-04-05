module Protocol.MapReader.Element.GraphicalElement;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Protocol.MapReader.Element.MapElement;
import Protocol.MapReader.Map;
import IO.BinaryReader;

class GraphicalElement : MapElement
{
	private BinaryReader m_reader;
	private Map m_map;

	private int m_elementId;
	private ubyte m_altitude;
	private int m_identifier;
	this(Map map, BinaryReader reader)
	{
		this.m_map = map;
		this.m_reader = reader;
		this.readGraphicalElement;
	}

	private void readGraphicalElement()
	{
		this.m_elementId = this.m_reader.readInt;
		//Hue
		this.m_reader.readBytes(3);
		//Shadow
		this.m_reader.readBytes(3);
		if(this.m_map.Version <= 4)
		{
			//Offset
			this.m_reader.readBytes(2);
		}else
		{
			this.m_reader.readShort;
			this.m_reader.readShort;
		}
		this.m_altitude = this.m_reader.readByte;
		this.m_identifier = this.m_reader.readInt;
	}

	override ushort Type() {
		return 2;
	}
}

