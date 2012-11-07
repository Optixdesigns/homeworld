import UnityEngine
/*=============================================================================
    Purpose : Logic for selecting ships and groups of ships.
=============================================================================*/

class Select(MonoBehaviour):
    public numSelectedShips as int
    #public selectedShips as ArrayList(GameObject)

    # HOW THE HELL AM I GOING TO SHOW THIS IN THE INSPECTOR
    public selectedShips as ArrayList = ArrayList()

    def Start():
        pass

    def Update():
        if Input.GetMouseButton(0):
            RightMouseClick()

    /*=============================================================================
        Purpose : Trigger apropiate functions on right mouse click
    =============================================================================*/
    def RightMouseClick():
        SelectionClick()

    /*=============================================================================
        Purpose : Select ship(s) / Group(s) on mouse click
    =============================================================================*/
    def SelectionClick():
        // Only if we hit something, do we continue
        hit as RaycastHit
        if not Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), hit):
            return

        // Check if this is an ship
        ship = hit.collider.gameObject
        if not ship.GetComponent[of ShipController](): 
            return

        // Can we select the ship
        if not ship.GetComponent[of ShipController]().selectable: 
            return
        
        // We got a hit
        SelectionSetSingleShip(ship)
        print('Hit a ship')
        # test movement
        team = ship.GetComponent[of AITeamController]()
        team.ChangeState(AITeamController.States.Moving)
        #ship.GetComponent[of AITeamController]().ChangeState(Moving)

    /*-----------------------------------------------------------------------------
        Name        : SelectionSetSingleShip
        Description : Select a single ship
        Inputs      : ship - ship to select
        Outputs     :
    ----------------------------------------------------------------------------*/
    def SelectionSetSingleShip(ship):
        numSelectedShips = 1
        selectedShips.Add(ship)
