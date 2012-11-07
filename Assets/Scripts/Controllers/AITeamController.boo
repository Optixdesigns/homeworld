import System
import System.Collections.Generic
import System.Text
import UnityEngine

[System.Serializable]
class AITeamController(MonoBehaviour):

    public enum States: 
        Init
        Idle
        Moving

    public enum Transitions: 
        StartMoving
    
    #private fsm as FSMSystem
    public target as GameObject
    public path as (Transform)

    // By making these public properties, and using [System.Serializable] in the state classes, these will now appear in the inspector
    public stateInit as StateInit = StateInit()
    public stateIdle as StateIdle = StateIdle()
    public stateMoving as StateMoving = StateMoving()

    // Reference to our state machine
    private fsm as FSMSystem[of AITeamController, AITeamController.States]

    public def Wake():
        pass

    public def Start():
        #Debug.Log(gameObject.GetInstanceID())
        self.MakeFSM()

    public def FixedUpdate():
        fsm.Update();

    // Setup our states
    private def MakeFSM():
        //Initialise the state machine
        fsm = FSMSystem[of AITeamController, AITeamController.States](self)
        fsm.RegisterState(stateInit)
        fsm.RegisterState(stateIdle)
        fsm.RegisterState(stateMoving)

        //Kick things off
        ChangeState(stateInit.ID)

    # MAKE THIS INTO TRANSITIONS
    public def ChangeState(state as States):
        fsm.ChangeState(state)


# Init state
[System.Serializable]
class StateInit(FSMState[AITeamController, AITeamController.States]):

    public override ID:
        get:
            return AITeamController.States.Init

    public override def Execute():
        controller = entity

        // Move to Idle
        controller.ChangeState(AITeamController.States.Idle)

# Idle state
class StateIdle(FSMState[AITeamController, AITeamController.States]):

    public override ID:
        get:
            return AITeamController.States.Idle

    public override def Enter():
        controller = entity
        #controller.ChangeState(controller.States.Moving)

    public override def Execute():
        pass
        #controller.SetTransition(Transition.StartMoving);

    public override def Exit():
        pass


# Move state
class StateMoving(FSMState[AITeamController, AITeamController.States]):

    private currentWayPoint as int
    private waypoints as (Transform)

    public override ID:
        get:
            return AITeamController.States.Moving

    public override def Enter():
        pass

    public override def Execute():
        controller = entity
        target = entity.target

        Debug.Log("attacker" + controller.gameObject.GetInstanceID())
        Debug.Log("target" + target.GetInstanceID())

        // Follow the path of waypoints
        // Find the direction of the player         
        velocity as Vector3 = controller.gameObject.rigidbody.velocity
        moveDir as Vector3 = (target.transform.position - controller.gameObject.transform.position)
        #Debug.Log(moveDir)
        #print(target)
        
        // Rotate towards the waypoint
        controller.gameObject.transform.rotation = Quaternion.Slerp(controller.gameObject.transform.rotation, Quaternion.LookRotation(moveDir), (5 * Time.deltaTime))
        controller.gameObject.transform.eulerAngles = Vector3(0, controller.gameObject.transform.eulerAngles.y, 0)
        
        velocity = (moveDir.normalized * 10)
        #Debug.Log(velocity)
        
        // Apply the new Velocity
        controller.gameObject.rigidbody.velocity = velocity
        #Debug.Log("moving")

    public override def Exit():
        pass
