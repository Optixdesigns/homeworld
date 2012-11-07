import UnityEngine
/*=============================================================================
    Purpose : Logic for selecting ships and groups of ships.
=============================================================================*/

class Select(MonoBehaviour):
    public numSelectedShips as int
    #public selectedShips as Dictionary[of Ship]
    public selectedShips as (GameObject)

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
        ship = hit.collider.GetComponent[of ShipController]()
        if not ship: 
            return

        // Can we select the ship
        if not ship.selectable: 
            return
        
        // We got a hit
        SelectionSetSingleShip(ship)
        print('Hit a ship')

    /*-----------------------------------------------------------------------------
        Name        : SelectionSetSingleShip
        Description : Select a single ship
        Inputs      : ship - ship to select
        Outputs     :
    ----------------------------------------------------------------------------*/
    def SelectionSetSingleShip(ship as ShipController):
        pass
        #dbgAssertOrIgnore(ship->playerowner == universe.curPlayerPtr);
        #selSelected.numShips = 1;
        #selSelected.ShipPtr[0] = ship;
        #selCentrePoint = ship->posinfo.position;