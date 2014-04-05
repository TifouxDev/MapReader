/*
Copyright (C) 2013	Munrek

This file is part of NuxbotD.

NuxbotD is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

NuxbotD is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with NuxbotD.  If not, see <http://www.gnu.org/licenses/>.
*/

module IO.BinaryReader;
import std.bitmanip;

class BinaryReader {
	ubyte[] _data;
	uint _index;
	private int currentPos;

	this(ubyte[] data) {
		
		_data = data.dup;
		currentPos = 0;
	}

	ubyte readByte() {
		ubyte value =  _data[currentPos];
		currentPos++;
		return value;
	}
	
	ubyte[] readBytes(ushort len) {
		ubyte[] value = new ubyte[len];
		for(int i  =0; i < len; i++)
		{
			value[i] = readByte();
		}
		//_data = _data[len..$];
		return value;
	}
	
	int readInt() {
		ubyte[4] data = readBytes(4);
		int value = bigEndianToNative!int(data);
		return value;
	}
	
	int readUInt() {
		ubyte[4] data = readBytes(4);
		uint value = bigEndianToNative!uint(data);
		return value;
	}	
	
	short readShort() {
		ubyte[2] data = readBytes(2);
		short value = bigEndianToNative!short(data);
		return value;
	}
	
	ushort readUShort() {
		ubyte[2] data = readBytes(2);
		ushort value = bigEndianToNative!ushort(data);
		return value;
	}
	
	double readDouble() {
		ubyte[8] data = readBytes(8);
		double value = bigEndianToNative!double(data);
		return value;
	}
	
	char[] readUTF() {
		ushort size = readUShort();
		ubyte[] data = readBytes(size);
		char[] string = cast(char[])data;
		return string;
	}
	
	char[] readUTFBytes(ushort size) {
		ubyte[] data = readBytes(size);
		char[] string = cast(char[])data;
		return string;
	}
	
	bool readBool() {
		bool value = true;
		if(readByte() == 0) return false;
		return value;
	}
	
	ubyte[] getData() {
		return _data;
	}
	
	void seek(int pos)
	{
		currentPos = pos;
	}

	ushort bytesAvailable()
	{
		return cast(ushort)(this._data.length - currentPos);
	}
}