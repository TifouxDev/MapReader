module Protocol.MapReader.Cell;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Protocol.MapReader.Element.MapElement;
import Protocol.MapReader.Map;
import IO.BinaryReader;
import Protocol.MapReader.Element.BasicElement;
class Cell
{
	private int m_cellId;
	private int m_elementsCount;
	private MapElement[] m_elements;
	private BinaryReader m_reader;
	private Map m_map;

	this(Map map, BinaryReader reader)
	{
		this.m_map = map;
		this.m_reader = reader;
		this.readCell;
	}


	private void readCell()
	{
		this.m_cellId = this.m_reader.readShort();
		this.m_elementsCount = this.m_reader.readShort;
		m_elements = new MapElement[this.m_elementsCount];
		for(int i = 0; i < m_elementsCount;i++)
		{
			m_elements[i] =	GetElementFromType(this.m_map, this.m_reader,this.m_reader.readByte);
		}
	}
}

