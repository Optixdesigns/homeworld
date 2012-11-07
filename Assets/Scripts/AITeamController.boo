import System
import System.Collections.Generic
import System.Text
import UnityEngine

# All the transitions for our state machine
/*
public enum Transition: 
    NullTransition = 0  # Use this transition to represent a non-existing transition in your system
    StartMoving = 1

# All the states for our state machine
public enum StateID:
    NullStateID = 0
    Idle = 1
    Moving = 2
*/    

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

    //By making these public properties, and using [System.Serializable] in the state classes, these will now appear in the inspector
    public stateInit as StateInit = StateInit()
    public stateIdle as StateIdle = StateIdle()
    public stateMoving as StateMoving = StateMoving()

    //The referecne to our state machine
    private fsm as FSMSystem[of AITeamController, AITeamController.States]

    public def Start():
        self.MakeFSM()

    public def FixedUpdate():
        pass
        #Debug.Log(self.fsm.CurrentState.ID)
        
        #self.fsm.CurrentState.Reason(self.gameObject)
        #self.fsm.CurrentState.Act(self.gameObject)

    # Setup our states
    private def MakeFSM():
        /*
        idleState = IdleState(AITeamController)
        moveState = MoveState(AITeamController, path)
        moveState.AddTransition(Transition.StartMoving, StateID.Moving);

        self.fsm = FSMSystem(AITeamController)
        self.fsm.AddState(idleState)
        self.fsm.AddState(moveState)
        */
        //Initialise the state machine
        fsm = FSMSystem[of AITeamController, AITeamController.States](self)
        fsm.RegisterState(stateInit)
        fsm.RegisterState(stateIdle)
        fsm.RegisterState(stateMoving)

        //Kick things off
        #ChangeState(stateInit.ID);
        fsm.ChangeState(stateInit.ID);


# Idle state
//All states should use the Serializable attribute if you want them to be visible in the inspector
class StateInit(FSMState[AITeamController, AITeamController.States]):

    public override ID:
        get:
            return AITeamController.States.Init

# Idle state
class StateIdle(FSMState[AITeamController, AITeamController.States]):

    public override ID:
        get:
            return AITeamController.States.Idle

    public override def Enter():
        pass
        #Debug.Log("kut")
        #super(IdleState).Reason()
        #controller = self.entity 
        #Debug.Log(controller)
        #controller = team.GetComponent[of AITeamController]()

        // Start moving when needed
        #controller.SetTransition(Transition.StartMoving);

    public override def Execute():
        pass

    public override def Exit():
        pass
        #super(IdleState, self).Act()


# Move state
class StateMoving(FSMState[AITeamController, AITeamController.States]):

    private currentWayPoint as int
    private waypoints as (Transform)

    public override ID:
        get:
            return AITeamController.States.Moving

    /*
    public def constructor(id, wp as (Transform)):
        self.waypoints = wp
        self.currentWayPoint = 0
    */
    public override def Enter():
        pass

    public override def Execute():
        pass

    public override def Exit():
        pass
        #super(MoveState, self).Act()
        /*

        controller = team.GetComponent[of AITeamController]()
        target = controller.target

        // Follow the path of waypoints
        // Find the direction of the player         
        vel as Vector3 = team.rigidbody.velocity
        moveDir as Vector3 = (target.transform.position - team.transform.position)
        
        // Rotate towards the waypoint
        team.transform.rotation = Quaternion.Slerp(team.transform.rotation, Quaternion.LookRotation(moveDir), (5 * Time.deltaTime))
        team.transform.eulerAngles = Vector3(0, team.transform.eulerAngles.y, 0)
        
        vel = (moveDir.normalized * 10)
        
        // Apply the new Velocity
        team.rigidbody.velocity = vel
        */
