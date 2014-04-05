module Protocol.MapReader.Element.SoundElement;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
import Protocol.MapReader.Element.MapElement;
import Protocol.MapReader.Map;
import IO.BinaryReader;

class SoundElement : MapElement
{
	private BinaryReader m_reader;
	private Map m_map;
	private int m_soundId;
	private short m_baseVolume;
	private int m_fullVolumeDistance;
	private int m_nullVolumeDistance;
	private short m_minDelayBetweenLoops;
	private short m_maxDelayBetweenLoops;

	this(Map map, BinaryReader reader)
	{
		this.m_map = map;
		this.m_reader = reader;
		this.readSoundElement;
	}

	private void readSoundElement()
	{
		this.m_soundId = this.m_reader.readInt;
		this.m_baseVolume = this.m_reader.readShort;
		this.m_fullVolumeDistance = this.m_reader.readInt;
		this.m_nullVolumeDistance = this.m_reader.readInt;
		this.m_minDelayBetweenLoops = this.m_reader.readShort;
		this.m_maxDelayBetweenLoops = this.m_reader.readShort;
	}

	override ushort Type() {
		return 33;
	}
}

