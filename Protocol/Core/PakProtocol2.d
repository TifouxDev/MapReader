module Protocol.Core.PakProtocol2;
/*  /////////////////////
 *   MapReader by tifoux
 *    Fonctionne que pour lire les maps attention n'essayer pas de lire les d2p des images etc...
 */////////////////////
import IO.BinaryReader;
import std.file;
import Utils.Logger;
import std.stdio;
import std.string;
import std.file;
import Protocol.Core.MapStruct;
import std.array;
import std.conv;
import Protocol.MapReader.Map;

class PakProtocol2
{
	private BinaryReader m_reader;
	private MapStruct[] maps;

	this(string path)
	{
		char[] cPath = cast(char[])path;
		// Conversion string to ubyte[] pour mon reader!
		ubyte[] bits = cast(ubyte[])read(path);

		this.m_reader = new BinaryReader(bits);

		this.d2pRead();// Todo lancement de la lecture du fichier
	}

	private void d2pRead()
	{
		if(!(this.m_reader.readByte == 2) ||!(this.m_reader.readByte == 1))
		{
			logError("Impossible de lire le fichier");
			return;
		}
		this.m_reader.seek(m_reader.getData.length - 24);

		int baseOffset = this.m_reader.readInt();
		int len = this.m_reader.readInt();
		int mapsOffset = this.m_reader.readInt();
		int mapsCount = this.m_reader.readInt();
		int fileOffset = this.m_reader.readInt();
		int lenghtFile = this.m_reader.readInt();

		this.m_reader.seek(fileOffset);
		for(int i = 0; i <lenghtFile;i++)
		{
			this.m_reader.readUTF();
			this.m_reader.readUTF();
		}

		this.m_reader.seek(mapsOffset);
		maps = new MapStruct[mapsCount];
		for(int i =0; i <mapsCount;i++)
		{
			string name = cast(string)this.m_reader.readUTF();
			int index = this.m_reader.readInt();
			int sizeMap = this.m_reader.readInt();
			maps[i] = new MapStruct(name,index,sizeMap,baseOffset);
		}
	}

	Map readMap(int id)
	{
		MapStruct mapToRead = null;
		foreach(MapStruct map;maps)
		{
			string[] mSplice = map.name().split("/");
			int len = mSplice.length;
			string currentLine = mSplice[len -1].replace(".dlm","");
			int currentID = to!int(currentLine);
			if(currentID == id)
				mapToRead = map;
		}

		if(mapToRead is null)
			return null;

		this.m_reader.seek(mapToRead.baseOffset + mapToRead.index);
		ubyte[] bits = this.m_reader.readBytes(cast(ushort)mapToRead.size);
		return new Map(new BinaryReader(bits));
	}
}

