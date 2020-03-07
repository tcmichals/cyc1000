#include <iostream>
#include <cstdint>
#include <thread>
#include "serialTransport.h"
#include "avalonProtocol.h"
#include "loopback.h"
#include "timer.h"
#include "sysid.h"
#include "gpioled.h"
#include "pwmdecoder.h"
#include "pwmOut.h"
//#include "dshot.h"

#if 0
static boost::asio::io_context gIOService(1);
std::size_t wait_count;
uint16_t speed_inc=0;
#define WAIT 5
void tick(boost::asio::deadline_timer *async_timer,
        boost::posix_time::millisec *interval,
        gpioAvalon *gpioLED,
        uint8_t *ledValue, 
        pwmDecoderAvalon *pwmDecoder,
        dshotAvalon *pwmOut) {


    async_timer->expires_at(async_timer->expires_at() + *interval);
    // Posts the timer event
    auto func = std::bind(  tick,
                            async_timer, 
                            interval, 
                            gpioLED, 
                            ledValue, 
                            pwmDecoder,
                            pwmOut);
    async_timer->async_wait(func);
    gpioLED->postLED((*ledValue)++);
    pwmDecoder->postRead();
    if ( wait_count < WAIT)
    {
        wait_count++;
        pwmOut->postDshotOut(0 );
        std::cout << "Waiting " << wait_count <<std::endl;
    }
    else
    {
    speed_inc +=20;
    // pwmOut->postDshotOut(MIN_ON + speed_inc);
     pwmOut->postDshotOut(158);
    if ((MIN_ON + speed_inc) > MID_ON)
        speed_inc = 100;

    }
    std::cout << __PRETTY_FUNCTION__ << " " << __LINE__ << std::endl;
}



int main(int argc, char **argv)
{

    boost::asio::signal_set signals(gIOService, SIGINT, SIGTERM);
    signals.async_wait([&](auto, auto){ gIOService.stop(); std::cout<< "stopping" << std::endl; });
    serialTransPort transPort(gIOService);

    std::string portName("/dev/ttyUSB0");
    if (false == transPort.start(portName))
    {
        std::cerr << "Error: cannot open(" << portName << ")" << std::endl;
        return -1;
    }
    boost::posix_time::millisec interval(5);  // 1 second
    boost::asio::deadline_timer async_timer(gIOService, interval);

    sysIDAvalon sysid(transPort);
    avalonTimer timer(transPort);
    gpioAvalon gpioLED(transPort);
    pwmDecoderAvalon pwmDecoder(transPort);
    //pwmOutAvalon pwmOut(transPort);
     dshotAvalon   pwmOut(transPort);

 //   boost::asio::post(gIOService, [&sysid](){ sysid.postReadID();});
 //   boost::asio::post(gIOService, [&timer](){  timer.isTimerRunning(); });
 //   boost::asio::post(gIOService, [&timer](){  timer.getCurrentTimerValue(); });
    uint8_t ledValue = 0;
    auto func = std::bind(tick, 
                            &async_timer, 
                            &interval, 
                            &gpioLED, 
                            &ledValue, 
                            &pwmDecoder,
                            &pwmOut);
    boost::asio::post(gIOService, [&gpioLED, &ledValue](){  gpioLED.postLED(ledValue++); });
    boost::asio::post(gIOService, [&pwmOut](){  pwmOut.postDshotOut(MIN_ON); });

    async_timer.async_wait(func);

  
    gIOService.run();
    transPort.dumpTimes();

}
#else


int main(int argc, char **argv)
{
    ftdiTransPort transPort;

    if (false == transPort.start())
    {
        std::cerr << "Error: cannot open()" << std::endl;
        return -1;
    }


    sysIDAvalon sysid(transPort);
    avalonTimer timer(transPort);
    gpioAvalon gpioLED(transPort);
    pwmDecoderAvalon pwmDecoder(transPort);
    pwmOutAvalon pwmOut(transPort);
    // dshotAvalon   pwmOut(transPort);

    uint8_t ledValue = 0;
    int timeout = 0;
    uint16_t pwmValue = MIN_ON;
    #define ARM_COUNT 1000
    #define SPEED_INC  100
    typedef enum
    {
        NOT_ARMED = 0,
        ARM_ARMED =1,
    }state_t;
    int state = NOT_ARMED;

    do 
    {
        std::this_thread::sleep_for(std::chrono::milliseconds(2));
        gpioLED.postLED(ledValue++);
      //  pwmOut.postPWMOut(pwmValue);

        timeout++;
        switch(state)
        {

            case NOT_ARMED:
                pwmValue = MIN_ON;
                if (timeout > ARM_COUNT)
                {
                    timeout = 0;
                    state = ARM_ARMED;
                    std::cout << "ARMED" << std::endl;
                }
            break;

            case ARM_ARMED:
                if ( timeout > SPEED_INC )
                {
                    timeout = 0;
                    pwmValue++;
                    if (pwmValue > 150)
                    {
                        timeout =0;
                        state = NOT_ARMED;
                          std::cout << "DISARMED" << std::endl;
                    }
                }



            break;
        }
        #if 0
        if ( timeout++ > COUNT)
        {
            if (pwmValue == MIN_ON)
            {
                pwmValue = MID_ON;
                std::cout << " MID_ON:" << pwmValue << std::endl;
            }
            else
            {
                pwmValue = MIN_ON;
                std::cout << "MIN_ON:" << pwmValue << std::endl;

            }
            timeout = 0;
        }
        #endif
        
    }while(true);



}
#endif

//eof
