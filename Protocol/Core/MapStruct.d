module Protocol.Core.MapStruct;
/*  /////////////////////
 *   MapReader by tifoux
 */////////////////////
public class MapStruct
{
	private string m_name;
	private int m_index;
	private int m_size;
	private int m_baseOffset;
	this(string name, int index, int size, int baseOffset)
	{
		this.m_name = name;
		this.m_index = index;
		this.m_size = size;
		this.m_baseOffset = baseOffset;
	}


	 string name()
	{
		return m_name;
	}


 int index()
	{
		return m_index;
	}

 int size()
	{
		return m_size;
	}

	int baseOffset()
	{
		return m_baseOffset;
	}
}

