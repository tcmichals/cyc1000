


class SerialPort
{

    constructor() 
    {
        this.connectionId = -1;
        this.rxCallback = null;
        this.txCallback = null;
        this.txQueue = [];
        this.txIsTransmitting = false;
    

    }

    isOpen()
    {
        if (this.connectionId == -1)
            return false;
        else
            return true;
    }

    Open( path)
    {
        chrome.serial.onReceiveError.addListener(function(value)
        {   
            this.onReceiveError(value);
        });
  
        let prom = new Promise( (resolve, reject) => {
        var lastError = null;
 
        try
        {
            chrome.serial.connect(path, {bitrate: 115200}, connectionInfo =>{
      
                if (chrome.runtime.lastError || connectionInfo==null)
                {
                    reject();
                }
                else
                {
                    console.log("connected");
                    this.txIsTransmitting = false;
                    this.txQueue = [];
                    this.connectionId = connectionInfo.connectionId;

                    let self = this;

                    chrome.serial.onReceive.addListener(function(args) 
                    {
                        if (self.rxCallback)
                        {
                            self.rxCallback.onReceive(args.data);
                        }
                        
                        if (self.txQueue.length && self.txIsTransmitting==false)
                        {
                            let buffer = self.txQueue.shift();
                            self.localWrite(buffer);
                        }

                    });
                    if (this.connectionId)
                            resolve();
                    else
                        reject();
                }
            });

            }
            catch(err)
            {
                console.log(err)
            }
        });

        return prom;
    }

    onReceiveError(info)
    {

    }

    processTxBytes(result)
    {
        

    }

    localWrite(buffer)
    {
        let self = this;
        let txBuffer = buffer;
        this.txIsTransmitting = true;
        chrome.serial.send(this.connectionId, buffer, function(result)
            {
                if (result.bytesSent)
                {
                    if (result.bytesSent != txBuffer.byteLength)
                        console.log("Not Done")
                    else
                    {
                        self.txIsTransmitting = false;
                    }

                }
                else
                {
                    console.log("Write: unhandled");
                }
            }
        );

    }

    Write( buffer)
    {
  
        if (this.txQueue.length == 0 &&  this.txIsTransmitting==false)
        {
            this.localWrite(buffer);
        }
        else
        {
            this.txQueue.push(buffer);
            console.log("Write Queued");
        }
       
    }


    Close()
    {
        let self = this;
        chrome.serial.disconnect(this.connectionId, function(result)
        {
            console.log("Closed");
            self.connectionId = -1;
        });
        this.connectionId = -1;
    }

    attachRxCallback(callback)
    {
        this.rxCallback = callback;
    }
 

}