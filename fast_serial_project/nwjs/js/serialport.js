

var currentSerial = null;
class SerialPort
{

    constructor() 
    {
        this.connectionId = -1;
        this.rxCallback = null;
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
                    this.connectionId = connectionInfo.connectionId;
                    currentSerial = this;
                    chrome.serial.onReceive.addListener(function(args) {
                                if (currentSerial.rxCallback)
                                {
                                    currentSerial.rxCallback.onReceive(args.data);
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

    Write( buffer)
    {
        chrome.serial.send(this.connectionId, buffer, function(result){
        }
        );
    }

    Close()
    {
        chrome.serial.disconnect(connectionId, function(result){
            console.log("Closed")
            this.connectionID = -1;
        });
    }

    attachRxCallback(callback)
    {
        this.rxCallback = callback;
    }
 

}