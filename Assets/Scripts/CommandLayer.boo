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
        #Debug.Log("Attack")
        for obj in selection:
            ship = obj.GetComponent[of Unit]()
            ship.target = target
            ship.fsm.ChangeActiveStateByIndex(2)

    def CancelAttack():
        // Cancel attack commando
        pass

    // Move selection to certain position
    def Move(selection as (GameObject), targetPosition as Vector3):
        // Move commando
        # USE SENDMESSAGES
        for obj in selection:
            ship = obj.GetComponent[of Unit]()
            ship.fsm.ChangeActiveStateByIndex(1)

    def CancelMove():
        // Cancel move commando
        pass
