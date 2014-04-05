module Protocol.MapReader.Fixture;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import IO.BinaryReader;
import Protocol.MapReader.Map;
import Utils.Logger;
class Fixture
{
	private BinaryReader m_reader;

	private int m_fixtureId;
	private int m_hue;
	private uint m_alpha;
	private int m_rotation;

	this(Map map, BinaryReader reader)
	{
		this.m_reader = reader;
		this.fixtureRead();
	}

	private void fixtureRead()
	{
		this.m_fixtureId = this.m_reader.readInt;

		//Offset
		this.m_reader.readShort;
		this.m_reader.readShort;
		//End
		this.m_rotation = this.m_reader.readShort;
		//Scale
		this.m_reader.readShort;
		this.m_reader.readShort;
		//End
		//Color r,gb
		this.m_reader.readBytes(3);
		//End
		this.m_hue = 0; //n'est pas utils pour ma se projet! (r | g | b)

		this.m_alpha = this.m_reader.readByte;
	}
}

