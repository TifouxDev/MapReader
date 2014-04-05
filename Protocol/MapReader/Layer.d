module Protocol.MapReader.Layer;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Protocol.MapReader.Map;
import Network.BinaryReader;
import Protocol.MapReader.Cell;
import Utils.Logger;
class Layer
{
	private Map m_map;
	private BinaryReader m_reader;

	private int m_layerId;
	private short m_cellsCount;
	private Cell[] cells;
	this(Map map, BinaryReader reader)
	{
		this.m_map = map;
		this.m_reader = reader;
		this.readLayer();
	}

	private void readLayer()
	{
		this.m_layerId = this.m_reader.readInt;
		this.m_cellsCount = this.m_reader.readShort;
		this.cells = new Cell[this.m_cellsCount];
		for(int i = 0; i < this.m_cellsCount; i++)
		{
			this.cells[i] = new Cell(this.m_map,this.m_reader);
		}
	}
}

