using UnityEngine;
using System.Collections;

public class plain : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	        /*
        AirDensity = 1
        WingArea = 1
        AirDrag = 1
        RollRate = 1
        ElevatorRate = 1
        torqueX = 400 * 0
        torqueY = 0.1f * 0
        weightCo = mass

        airSpeedVector as Vector3 = -rigidbody.velocity

        CurrentSpeed = rigidbody.velocity.magnitude
        angleOfAttack as single = -Mathf.Deg2Rad * Vector3.Dot(rigidbody.velocity, transform.up)
        slipAoA as single = -Mathf.Deg2Rad * Vector3.Dot(rigidbody.velocity, transform.right)
        speedWeight as single = AirDensity * ((CurrentSpeed*CurrentSpeed)/2)

        sideSlipCoefficient = 0.001f * slipAoA * speedWeight
        liftCoefficient = WingArea * angleOfAttack * speedWeight

        horizonAngle as single = Vector3.Dot(transform.forward, Vector3.up)
        dragCoefficient = 2*AirDrag + 2 * AirDrag * horizonAngle
        thrustCoefficient = thrust
        AoA = Vector3.Dot(transform.up, Vector3.up)

        //************************************************************
        // Pitch from lift, yaw & roll from sideslip
        //************************************************************
        rollCoEfficient = -(torqueY+ay) * RollRate * speedWeight;
        pitchCoEfficient =  (torqueX+ax) * ElevatorRate * speedWeight; 
        yawCoEfficient = 0;

        pitchCoEfficient += liftCoefficient * 0.001f;
        yawCoEfficient += -sideSlipCoefficient * 2f;
        rollCoEfficient += -sideSlipCoefficient * 0.1f;

        //************************************************************
        // Calc vectors now we have coefficients
        //************************************************************
        WeightVector = Vector3.down * weightCo;


        ThrustForceVector = transform.forward * thrustCoefficient;     
        LiftVector = transform.up * liftCoefficient;
        DragVector = airSpeedVector * dragCoefficient;
        SideSlip = Vector3.right * sideSlipCoefficient;

        RollTorque = Vector3.forward * rollCoEfficient;
        YawTorque = Vector3.up * yawCoEfficient;     
        PitchTorque = Vector3.right * pitchCoEfficient;

        //************************************************************
        // Apply forces
        //************************************************************
        rigidbody.AddForce(ThrustForceVector, ForceMode.Force);
        rigidbody.AddForce(DragVector, ForceMode.Force);
        rigidbody.AddForce(LiftVector, ForceMode.Force);
        rigidbody.AddForce(WeightVector, ForceMode.Force);
        rigidbody.AddForce(SideSlip, ForceMode.Force);

        rigidbody.AddRelativeTorque(RollTorque);
        rigidbody.AddRelativeTorque(YawTorque);
        rigidbody.AddRelativeTorque(PitchTorque);
        */
	}
}
