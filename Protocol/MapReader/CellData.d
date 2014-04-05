module Protocol.MapReader.CellData;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Protocol.MapReader.Map;
import Network.BinaryReader;
import Utils.Logger;
class CellData
{
	private Map m_map;
	private BinaryReader m_reader;

	private double m_floor;
	private ubyte m_lostmov;
	private ubyte m_speed;
	private ubyte m_mapChangeData;
	private int m_id;
	this(Map map, BinaryReader reader, int id)
	{
		this.m_id = id;
		this.m_map = map;
		this.m_reader = reader;
		this.readCellData();
	}

	private void readCellData()
	{
		this.m_floor = this.m_reader.readByte * 10;
		if(this.m_floor == -1280)
		{
			logError("Erreur floor");
			return;
		}
		this.m_lostmov = this.m_reader.readByte;
		this.m_speed = this.m_reader.readByte;
		this.m_mapChangeData = this.m_reader.readByte;
		if(this.m_map.Version > 5)
			this.m_reader.readByte;

		if(this.m_map.Version > 7)
			this.m_reader.readByte;

	}

	public bool Mov()
	{
		return (this.m_lostmov & 1) == 1;
	}

	public ubyte MapChangeData()
	{
		return this.m_mapChangeData;
	}

	public int CellID()
	{
		return m_id;
	}
}

