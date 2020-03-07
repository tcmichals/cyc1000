/* simple.c
   Simple libftdi usage example
   This program is distributed under the GPL, version 2
*/
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <memory>


#include <libftdi1/ftdi.h>


class ftdi_context_wrapper
{

protected:
    struct ftdi_context *pFTDIContext;
    public:
        ftdi_context_wrapper();
        ~ftdi_context_wrapper();
         struct ftdi_context *get();

};

inline
ftdi_context_wrapper::ftdi_context_wrapper()
{
   pFTDIContext= ftdi_new();
}
inline
ftdi_context_wrapper::~ftdi_context_wrapper()
{

    if (pFTDIContext)
        ftdi_free(pFTDIContext);
}

inline
struct ftdi_context *ftdi_context_wrapper::get()
{
    return pFTDIContext;
}


int main(void)
{
    int ret;
    auto  ftdi = std::make_unique<ftdi_context_wrapper>();
    struct ftdi_version_info version;

  if (ftdi->get() == nullptr)
   {
        fprintf(stderr, "ftdi_new failed\n");
        return EXIT_FAILURE;
    }
    version = ftdi_get_library_version();
    printf("Initialized libftdi %s (major: %d, minor: %d, micro: %d, snapshot ver: %s)\n",
        version.version_str, version.major, version.minor, version.micro,
        version.snapshot_str);
    if ((ret = ftdi_usb_open(ftdi->get(), 0x0403, 0x6010)) < 0)
    {
        fprintf(stderr, "unable to open ftdi device: %d (%s)\n", ret, ftdi_get_error_string(ftdi->get()));
        return EXIT_FAILURE;
    }
    // Read out FTDIChip-ID of R type chips
    if (ftdi->get()->type == TYPE_2232H)
    {
        unsigned int chipid;
        printf("ftdi_read_chipid: %d\n", ftdi_read_chipid(ftdi->get(), &chipid));
        printf("FTDI chipid: %X\n", chipid);
    }

    if ( 0 < ftdi_set_interface(ftdi->get(), INTERFACE_B))
    {
        std::cerr<< "failed:ftdi_set_interface" << std::endl;
        return -1;
    }

    uint8_t counter = 0;
    if ( 0 < ftdi_get_latency_timer(ftdi->get(),&counter))
    {
        std::cerr<< "failed:ftdi_get_latency_timer" << std::endl;
        return -1;

    }
    std::cout << "timer:" << int(counter) << std::endl;

        if ( 0 < ftdi_set_latency_timer(ftdi->get(), 1))
    {
        std::cerr<< "failed:ftdi_set_latency_timer" << std::endl;
        return -1;

    }



    if ((ret = ftdi_usb_close(ftdi->get())) < 0)
    {
        fprintf(stderr, "unable to close ftdi device: %d (%s)\n", ret, ftdi_get_error_string(ftdi->get()));
   //     ftdi_free(ftdi);
        return EXIT_FAILURE;
    }
  //  ftdi_free(ftdi);
    return EXIT_SUCCESS;
}

