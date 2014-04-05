module Protocol.MapReader.Map;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Network.BinaryReader;
import Utils.Logger;
import std.zlib;
import std.conv;
import Utils.MapInfo;
import std.stdio;
import std.array;
import std.conv;
import Protocol.MapReader.Fixture;
import Protocol.MapReader.Element.BasicElement;
import Protocol.MapReader.Layer;
import Protocol.MapReader.CellData;
class Map
{
	private BinaryReader m_reader;
	//Map Struct
	private ubyte m_mapType;
	private int m_id;
	private ubyte m_encryptionVersion;
	private uint m_relativeId;
	private ubyte m_version;
	private int m_subAreaId;
	private bool m_encrypted;
	private int m_topNeighbourId;
	private int m_bottomNeighbourId;
	private int m_leftNeighbourId;
	private int m_rightNeighbourId;
	private int m_shadowBonusOnEntities;
	private bool m_useLowPassFilter;
	private bool m_useReverb;
	private int m_presetId;
	private int m_groundCRC;
	private Fixture[] m_foregroundFixtures;
	private Fixture[] m_backgroudFixtures;
	private Layer[] m_layers;
	private CellData[] m_cells;
	this(BinaryReader reader)
	{
		this.m_reader = reader;

		this.readMap();
	}

	void readMap()
	{
		ubyte header = this.m_reader.readByte();
		if(header != 77)
		{
			this.m_reader.seek(0);
			ubyte[] deflate = cast(ubyte[])uncompress(this.m_reader.readBytes(this.m_reader.bytesAvailable));;
			this.m_reader = new BinaryReader(deflate);
			header = this.m_reader.readByte();
			if(header != 77)
			{
				logError("Header invalide");
				return;
			}
		}

		this.m_version = this.m_reader.readByte;
		this.m_id = this.m_reader.readInt;
	
		if(m_version >= 7)
		{
			this.m_encrypted = this.m_reader.readBool;
			this.m_encryptionVersion = this.m_reader.readByte;
			int len = this.m_reader.readInt;
		
			ubyte[] decryptKey = cast(ubyte[])MapKey;
			int lenDec = decryptKey.length;

			if(this.m_encrypted)
			{
				ubyte[] encryptedData = this.m_reader.readBytes(cast(ushort)len);
				for(int i = 0; i <encryptedData.length;i++)
				{
					encryptedData[i] = cast(ubyte)(encryptedData[i]^decryptKey[i % lenDec]);
				}
				this.m_reader = new BinaryReader(encryptedData);
			}
			this.m_relativeId =cast(uint)this.m_reader.readInt;
		
			this.m_mapType = this.m_reader.readByte;
			this.m_subAreaId = this.m_reader.readInt;
			this.m_topNeighbourId = this.m_reader.readInt;
			this.m_bottomNeighbourId = this.m_reader.readInt;
			this.m_leftNeighbourId = this.m_reader.readInt;;
			this.m_rightNeighbourId = this.m_reader.readInt;
			this.m_shadowBonusOnEntities = this.m_reader.readInt;
			if(this.m_version >=3)
			{
				this.m_reader.readBytes(3); //lecteur des trois couleur rgb
			}

			if(this.m_version >= 4)
			{
				this.m_reader.readUShort;
				this.m_reader.readShort;
				this.m_reader.readShort;
			}

			this.m_useLowPassFilter = this.m_reader.readByte == 1;
			this.m_useReverb = this.m_reader.readByte == 1;
			if(m_useReverb)
				m_presetId = this.m_reader.readInt;
			else
				m_presetId = -1;

			ubyte bgCount = this.m_reader.readByte;
			m_backgroudFixtures = new Fixture[bgCount];
			for(int i; i < bgCount;i++)
			{
				m_backgroudFixtures[i] = new Fixture(this, this.m_reader);
			}

			ubyte fgCount = this.m_reader.readByte;
			m_foregroundFixtures = new Fixture[fgCount];
			for(int i; i < fgCount;i++)
			{
				m_foregroundFixtures[i] = new Fixture(this, this.m_reader);
			}

			this.m_reader.readInt;
			this.m_groundCRC = this.m_reader.readInt;

			ubyte layerCount = this.m_reader.readByte;
			m_layers = new Layer[layerCount];
			for(int i = 0; i < layerCount;i++)
			{
				m_layers[i] = new Layer(this, this.m_reader);
			}

			m_cells = new CellData[560];
			for(int i = 0; i < 560; i++)
			{
				m_cells[i] = new CellData(this,this.m_reader, i);
				CellData cell = m_cells[i];
			}
		}
	}

	public ubyte Version()
	{
		return m_version;
	}

	public CellData[] Cells()
	{
		return this.m_cells;
	}
}

