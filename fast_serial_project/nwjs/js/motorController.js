

const motorProtocolNum = { 0:"PWM", 
                           1: "ONESHOT150",
                        2:"DSHOT150" };

const MAX_MOTOR_COUNT = 4;
const PWM = 0
const ONESHOT150 = 1;
const DSHOT150 = 2;

class MotorController
{

    constructor(bus)
    {
        this.protocol = DSHOT150;
        this.bus = bus;
        this.updateMotorTimer = null;
        this.motorUpdateValue= [0,0,0,0];

    }

    getProtocolStr()
    {
        return motorProtocolNum[this.protocol]
    }

    setProtocol(value)
    {
        switch(value)
        {
            case PWM:
            case ONESHOT150:
            case DSHOT150:
                this.protocol = value;
            break;
        }
    }

    updateMotorValue(motor, value)
    {


    }

    enableMotor(motor)
    {
        
    }

    setUpdateRate(rateInMS)
    {

    }


}