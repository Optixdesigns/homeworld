import UnityEngine

// =============================================================================
//  - This is the ship command layer. All commando's run through here
// =============================================================================


class CommandLayer(MonoBehaviour): 

    def Start ():
        pass
    
    def Update ():
        pass


    def Attack(ships as List[of Ship]):
        // Attack commando
        pass

    def CancelAttack():
        // Cancel attack commando
        pass

    // Move selection to certain position
    def Move(selection as List[of Ship], targetPosition as Vector3):
        // Move commando
        # USE SENDMESSAGES
        pass
        #for ship in selection: # should wrap selection into a gameobject
            #print(targetPosition) 
            #ship.moveToPosition = targetPosition
            #ship.behaviours.ChangeState(ship.behaviours.behaviourOnMove)
        #for ship in ships:  
            #ship.Move(targetVector)

    def CancelMove():
        // Cancel move commando
        pass
