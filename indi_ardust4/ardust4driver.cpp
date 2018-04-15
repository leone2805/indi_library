/*******************************************************************************
  Copyright(c) 2012 Jasem Mutlaq. All rights reserved.

  This program is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; see the file COPYING.LIB.  If not, write to
  the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  Boston, MA 02110-1301, USA.

  The full GNU General Public License is included in this distribution in the
  file called LICENSE.
*******************************************************************************/
#include "ardust4driver.h"
#include <indidevapi.h>
#include <wiringPi.h>

ARDUST4Driver::ARDUST4Driver(std::string device)
{
    guideCMD[0]=0;
    debug=false;
    this->device = device;
    wiringPiSetup();
    pinMode (0, OUTPUT) ;
}

ARDUST4Driver::~ARDUST4Driver()
{
   pinMode(0, INPUT);
}



bool ARDUST4Driver::Connect()
{
  return true;

}

bool ARDUST4Driver::Disconnect()
{
    return true;
}

bool ARDUST4Driver::startPulse(int direction)
{
    int rc=0;
    std::string command;
    digitalWrite(0,HIGH);
    switch (direction)
    {
        case ARDUST4_NORTH:
        if (debug) IDLog("Start North\n");
        command = "RA+#";
        break;

        case ARDUST4_WEST:
        if (debug) IDLog("Start West\n");
        command = "DEC+#";
        break;

        case ARDUST4_SOUTH:
        if (debug) IDLog("Start South\n");
        command = "RA-#";
        break;

        case ARDUST4_EAST:
        if (debug) IDLog("Start East\n");
        command = "DEC-#";
        break;
    }

   IDLog("start command value is %s\n", command.c_str());

   rc = write_blocking(command);

  IDLog("startPulse returns %d\n",rc);
    if(rc==1)
        return true;

    return false;
}

bool ARDUST4Driver::stopPulse(int direction)
{
   int rc=0;
   std::string command;
   digitalWrite(0,LOW);
    switch (direction)
    {
        case ARDUST4_NORTH:
        if (debug) IDLog("Stop North\n");
        command = "RA0#";
        break;

        case ARDUST4_WEST:
        if (debug) IDLog("Stop West\n");
        command = "DEC0#";
        break;

        case ARDUST4_SOUTH:
        if (debug) IDLog("Stop South\n");
        command = "RA0#";
        break;

        case ARDUST4_EAST:
        if (debug) IDLog("Stop East\n");
        command = "DEC0#";
        break;
    }


    if (debug)
        IDLog("stop command value is %s\n", command.c_str());

    rc = write_blocking(command);


    if (debug)
        IDLog("stopPulse returns %d\n",rc);
    if(rc==1)
        return true;

    return false;

}


bool ARDUST4Driver::write_blocking(std::string s){
  return true;
}

