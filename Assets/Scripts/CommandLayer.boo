import UnityEngine

// =============================================================================
//  - This is the ship command layer. All commando's run through here
// =============================================================================


class CommandLayer(MonoBehaviour): 

    def Start ():
        pass
    
    def Update ():
        pass

    def Attack(selection as (GameObject), target as GameObject):
        for obj in selection:
            ship = obj.GetComponent[of Ship]()
            ship.target = target
            ship.fsm.ChangeActiveStateByIndex(2)

    def CancelAttack():
        // Cancel attack commando
        pass

    // Move selection to certain position
    def Move(selection as (GameObject), targetPosition as Vector3):
        // Move commando
        # USE SENDMESSAGES
        #pass
        for obj in selection:
            ship = obj.GetComponent[of Ship]()
            ship.fsm.ChangeActiveStateByIndex(1)
        #pass
        #for ship in selection: # should wrap selection into a gameobject
            #print(targetPosition) 
            #ship.moveToPosition = targetPosition
            #ship.behaviours.ChangeState(ship.behaviours.behaviourOnMove)
        #for ship in ships:  
            #ship.Move(targetVector)

    def CancelMove():
        // Cancel move commando
        pass
