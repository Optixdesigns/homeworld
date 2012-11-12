import UnityEngine
/*=============================================================================
    Purpose : Logic for selecting ships and groups of ships.
=============================================================================*/

class Select(MonoBehaviour):

    private numSelectedShips as int
    #public selectedShips as List[of GameObject] = List[of GameObject]()
    public selectedShips as List[of Ship] = List[of Ship]() // Reference to the selected ships
    private _command as CommandLayer
    
    def Start():
        _command = GetComponent(typeof(CommandLayer))
        #command = GameObject.Find("GameManager").GetComponent[of CommandLayer]()

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
        target = hit.collider.gameObject
        if not CheckIfShip(target):
            return

        // Send move command
        _command.Move(selectedShips, target.transform.position)
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
        #if not obj.GetComponent[of ShipProperties]().selectable: 
            #return
        
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
