#pragma once
#include <cstdint>
#include <functional>


class transportAvalon
{

public:
    typedef std::function< bool (int errCode, 
                                const uint8_t *pRx, 
                                size_t bytesRead)> ReadEvt_t;

    typedef std::vector<uint8_t> array_t;

    typedef std::function<void (int errno, size_t byteSent)> txDone_Callback_t;
    typedef std::function<void (int errno, const array_t &rxBuffer)> rxDone_Callback_t;

    
public:
    transportAvalon();
virtual ~transportAvalon();
virtual bool postTransaction(const array_t &,
                            const txDone_Callback_t &,
                            const rxDone_Callback_t &) =0;

};


inline
transportAvalon::transportAvalon()
{

}

inline 
transportAvalon::~transportAvalon()
{

}





