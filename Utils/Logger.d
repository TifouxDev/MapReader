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

module Utils.Logger;

import std.stdio;

// 0 NORMAL
// 1 INFO
// 2 WARN
// 3 ERROR
// 4 DEBUG

version(Windows){
	
	void log(T...)(T params) {
		writeln("[MESSAGE] ", params);
	}
	
	void logInfo(T...)(T params) {
		writeln("[INFO] ", params);
	}
	
	void logWarning(T...)(T params) {
		writeln("[WARNING] ", params);
	}

	void setTitle(char* text)
	{
		stdin.SetConsoleTitleA(text);
	}
	
	void logError(T...)(T params) {
		writeln("[ERROR] ", params);
	}
	
	void logDebug(T...)(T params) {
		writeln("[DEBUG] ", params);
	}
	
}