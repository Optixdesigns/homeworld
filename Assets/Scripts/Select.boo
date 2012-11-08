import UnityEngine
/*=============================================================================
    Purpose : Logic for selecting ships and groups of ships.
=============================================================================*/

class Select(MonoBehaviour):

    private numSelectedShips as int
    #public selectedShips as List[of GameObject] = List[of GameObject]()
    public selectedShips as List[of Ship] = List[of Ship]()

    def Start():
        pass

    def Update():
        if Input.GetMouseButtonDown(0):
            RightMouseClick()

        if Input.GetMouseButtonDown(1):
            LeftMouseClick()

    /*=============================================================================
        Purpose : Trigger apropiate functions on RIGHT mouse click
    =============================================================================*/
    def RightMouseClick():
        SelectionClick()

    /*=============================================================================
        Purpose : Trigger apropiate functions on LEFT mouse click
    =============================================================================*/
    def LeftMouseClick():
        ObjectClick()

    def ObjectClick():
        // Only if we hit something, do we continue
        hit as RaycastHit
        if not Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), hit):
            return

        // Check if this is an ship
        ship = hit.collider.gameObject
        if not CheckIfShip(ship):
            return

        // Set target for selected ships and move
        for i in range(selectedShips.Count):
            __shipController = selectedShips[i].GetComponent[of Ship]()
            __shipController.target = ship
            __shipController.behaviourOnMove.enabled = true
            #teamController.ChangeState(AITeamController.States.Moving)

        print("Target selected")

    /*=============================================================================
        Purpose : Select ship(s) / Group(s) on mouse click
    =============================================================================*/
    def SelectionClick():
        // Only if we hit something, do we continue
        hit as RaycastHit
        if not Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), hit):
            return

        // Check if this is an ship
        obj = hit.collider.gameObject
        if not CheckIfShip(obj):
            return

        // Can we select the ship
        if not obj.GetComponent[of ShipProperties]().selectable: 
            return
        
        // We got a hit
        SelectionSetSingleShip(obj.GetComponent[of Ship]())
        print("Ship selected")

    def CheckIfShip(obj as GameObject):
        if obj.GetComponent[of Ship]():
            return true

        return false

    /*-----------------------------------------------------------------------------
        Name        : SelectionSetSingleShip
        Description : Select a single ship
        Inputs      : ship - ship to select
        Outputs     :
    ----------------------------------------------------------------------------*/
    def SelectionSetSingleShip(ship):
        numSelectedShips = 1
        selectedShips.Push(ship)
