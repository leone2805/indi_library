/*
   "Simple CCD Driver"

*/

/** \file simpleccd.h
    \author Leone Di Mario

    \example simpleccd.h
    A simple CCD device that can capture images from JPEG file. It returns a FITS image to the client. To build drivers for complex CCDs, please
    refer to the INDI Generic CCD driver template in INDI SVN (under 3rdparty).
*/

#pragma once

#include "indiccd.h"

class SimpleCCD : public INDI::CCD
{
  public:
    SimpleCCD() = default;

  protected:
    // General device functions
    bool Connect();
    bool Disconnect();
    const char *getDefaultName();
    bool initProperties();
    bool updateProperties();

    // CCD specific functions
    bool StartExposure(float duration);
    bool AbortExposure();
    int SetTemperature(double temperature);
    void TimerHit();

  private:
    // Utility functions
    float CalcTimeLeft();
    void setupParams();
    void grabImage();

    // Are we exposing?
    bool InExposure { false };
    // Struct to keep timing
    struct timeval ExpStart { 0, 0 };

    float ExposureRequest { 0 };
    float TemperatureRequest { 0 };
};
