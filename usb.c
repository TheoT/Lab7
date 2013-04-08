#include "mex.h"
#include <libusbx-1.0/libusb.h>

#define INITIALIZE          0
#define DEINITIALIZE        1
#define SET_DEBUG           2
#define OPEN_DEVICE         3
#define CLOSE_DEVICE        4
#define NUM_DEVICES_OPEN    5
#define CONTROL_TRANSFER    6

#define FALSE               0
#define TRUE                1

#define MAX_DEVICES_OPEN    10

libusb_device_handle *open_devices[MAX_DEVICES_OPEN];
int devices_open, initialized = FALSE;

void initialize(void) {
    int i;

    if (initialized==FALSE) {
        initialized = TRUE;
        libusb_init(NULL);

        devices_open = 0;
        for (i = 0; i<MAX_DEVICES_OPEN; i++)
            open_devices[i] = NULL;
    }
}

void deinitialize(void) {
    if (initialized==TRUE) {
        initialized = FALSE;
        libusb_exit(NULL);
    }
}

void set_debug(int level) {
    libusb_set_debug(NULL, level);
}

int open_device(unsigned int vendorID, unsigned int productID, int n) {
    libusb_device **list, *dev;
    libusb_device_handle *dev_handle;
    ssize_t cnt, j;
    struct libusb_device_descriptor desc;
    int err, i;
    
    cnt = libusb_get_device_list(NULL, &list);
    if (cnt<0) {
        libusb_free_device_list(list, 1);
        return -4;  /* Indicates no USB devices found at all. */
    }

    i = 0;
    for (j = 0; j<cnt; j++) {
        dev = list[j];
        libusb_get_device_descriptor(dev, &desc);
        if ((desc.idVendor==vendorID) && (desc.idProduct==productID)) {
            if (i==n) {
                for (i = 0; i<MAX_DEVICES_OPEN; i++) {
                    if (open_devices[i]==NULL) {
                        err = libusb_open(dev, &dev_handle);
                        open_devices[i] = dev_handle;
                        libusb_free_device_list(list, 1);
                        if (err) {
                            return -1;  /* Indicates matching USB device found, but could not be opened. */
                        } else {
                            devices_open++;
                            return i;
                        }
                    }
                }
                libusb_free_device_list(list, 1);
                return -2;  /* Indicates matching USB device found, but too many devices already opened. */
            } else {
                i++;
            }
        }
    }
    libusb_free_device_list(list, 1);
    return -3;  /* Indicates no matching USB device found. */
}

int close_device(int device) {
    if ((device<0) || (device>=MAX_DEVICES_OPEN))
        return -1;
    if (open_devices[device]) {
        libusb_close(open_devices[device]);
        devices_open--;
        open_devices[device] = NULL;
        return 0;
    }
    return -2;
}

int num_devices_open(void) {
    return devices_open;
}

int control_transfer(int device, unsigned char bmRequestType, unsigned char bRequest, unsigned int wValue, unsigned int wIndex, unsigned int wLength, unsigned char *buffer) {
    if ((device<0) || (device>=MAX_DEVICES_OPEN))
        return -1;
    if (open_devices[device])
        return libusb_control_transfer(open_devices[device], (uint8_t)bmRequestType, (uint8_t)bRequest, (uint16_t)wValue, (uint16_t)wIndex, buffer, (uint16_t)wLength, 0);
    return -2;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    int action, device, value;
    unsigned char buffer[64], i, bmRequestType, bRequest;
    unsigned int vendorID, productID, wValue, wIndex, wLength;
    double *ret, *out;

    action = (int)(mxGetScalar(prhs[0]));
    switch (action) {
        case INITIALIZE:
            initialize();
            break;
        case DEINITIALIZE:
            deinitialize();
            break;
        case SET_DEBUG:
            value = (int)(mxGetScalar(prhs[1]));
            set_debug(value);
            break;
        case OPEN_DEVICE:
            vendorID = (unsigned int)(mxGetScalar(prhs[1]));
            productID = (unsigned int)(mxGetScalar(prhs[2]));
            value = (int)(mxGetScalar(prhs[3]));
            value = open_device(vendorID, productID, value);
            plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
            ret = mxGetPr(plhs[0]);
            ret[0] = (double)value;
            break;
        case CLOSE_DEVICE:
            device = (int)(mxGetScalar(prhs[1]));
            value = close_device(device);
            plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
            ret = mxGetPr(plhs[0]);
            ret[0] = (double)value;
            break;
        case NUM_DEVICES_OPEN:
            value = num_devices_open();
            plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
            ret = mxGetPr(plhs[0]);
            ret[0] = (double)value;
            break;
        case CONTROL_TRANSFER:
            device = (int)(mxGetScalar(prhs[1]));
            bmRequestType = (unsigned char)(mxGetScalar(prhs[2]));
            bRequest = (unsigned char)(mxGetScalar(prhs[3]));
            wValue = (unsigned int)(mxGetScalar(prhs[4]));
            wIndex = (unsigned int)(mxGetScalar(prhs[5]));
            wLength = (unsigned int)(mxGetScalar(prhs[6]));
            value = control_transfer(device, bmRequestType, bRequest, wValue, wIndex, wLength, buffer);
            plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
            ret = mxGetPr(plhs[0]);
            ret[0] = (double)value;
            plhs[1] = mxCreateDoubleMatrix(1, 64, mxREAL);
            out = mxGetPr(plhs[1]);
            for (i = 0; i<64; i++)
                out[i] = (double)buffer[i];
            break;
        default:
            mexErrMsgTxt("Illegal action specified.");
    }
}
