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

module Network.BinaryWriter;

import std.bitmanip;

class BinaryWriter {
	ubyte[] _data;
	uint _index;
	
	this() {
		
	}
	
	void writeByte(ubyte data) {
		_data ~= data;
	}
	
	void writeBytes(ubyte[] data) {
		_data ~= data;
	}
	
	void writeInt(int data) {
		ubyte[4] value = nativeToBigEndian(data);
		writeBytes(value);
	}
	
	void writeUInt(uint data) {
		ubyte[4] value = nativeToBigEndian(data);
		writeBytes(value);
	}
	
	void writeShort(short data) {
		ubyte[2] value = nativeToBigEndian(data);
		writeBytes(value);
	}
	
	void writeUShort(ushort data) {
		ubyte[2] value = nativeToBigEndian(data);
		writeBytes(value);		
	}
	
	void writeDouble(double data) {
		ubyte[8] value = nativeToBigEndian(data);
		writeBytes(value);
	}
	
	void writeUTF(char[] data) {
		ushort size = cast(ushort)data.length;
		ubyte[] string = cast(ubyte[])data;
		writeUShort(size);
		writeBytes(string);
	}
	
	void writeUTFBytes(char[] data) {
		ubyte[] string = cast(ubyte[])data;
		writeBytes(string);
	}
	
	void writeBool(bool data) {
		if(data) writeByte(1);
		if(!data) writeByte(0);
	}
	
	ubyte[] getData() {
		return _data;
	}
}