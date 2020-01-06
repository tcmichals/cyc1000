#include <cstdint>
#include <functional>
#include "addressmap.h"
#include "avalonProtocol.h"

class apa102LED
{

protected:
    typedef enum
    {
        number_of_leds = 8,
    }numLEDS_t;

    enum class whichLED
    {
        LED_1,
        LED_2,
        LED_3,
        LED_4,
        LED_5,
        LED_6,
        LED_7,
        LED_8
    };
    const std::array<whichLED,8> allLEDS = { whichLED::LED_1,
                                             whichLED::LED_2,
                                             whichLED::LED_3,
                                             whichLED::LED_4,
                                             whichLED::LED_5,
                                             whichLED::LED_6,
                                             whichLED::LED_7,
                                             whichLED::LED_8,
                                            };

protected:
    std::array<uint32_t, number_of_leds> m_leds;

void set_led(whichLED index=whichLED::LED_1,
             uint8_t brightness=0x1f, 
             uint8_t blue=0xff, 
             uint8_t green=0xff, 
             uint8_t red=0xff);

bool uppdate();
public:
apa102LED();
virtual ~apa102LED();

};

inline
apa102LED::apa102LED()
{
    for(auto &index: allLEDS)
        set_led(index);
}

inline
apa102LED::~apa102LED()
{

}

inline 
void apa102LED::set_led( whichLED index,
                        uint8_t brightness=0x1f, 
                        uint8_t blue=0xff, 
                        uint8_t green=0xff, 
                        uint8_t red=0xff)
{
    uint32_t val= ((brightness | 0xE0) << 24) | (blue << 16) | (green << 8) | red;
    m_leds[static_cast<size_t>(index)] =val;

}

inline 
bool apa102LED::update()
{
 

    
	m_bus.transaction_channel_read(callback,
								SYSID_START_ADDRESS, 
								AVALON_CHANNEL, 
								4, 
								Avalon_Trans_Type::WRITE_INCREMENTING);
}




