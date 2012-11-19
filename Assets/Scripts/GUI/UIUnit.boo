import UnityEngine

// UI For spaceobjects
[AddComponentMenu("Neworld/Unit UI")]
class UIUnit(MonoBehaviour):
    public unit as GameObject
    public unitController as Ship

    public cursor as Texture2D
    public cursorAttack as Texture2D
    public cursorMode as CursorMode = CursorMode.Auto
    public hotSpot as Vector2 = Vector2.zero

    private draw as bool = false

    def Awake():
        unit = gameObject
        unitController = unit.GetComponent[of Ship]()
    
    def Update():
        if unitController.select and unitController.select.isSelected:
            draw = true
        else:
            draw = false    

    def OnGUI():
        if draw:
            screenPosition as Vector3 = Camera.main.WorldToScreenPoint(unit.transform.position) // gets screen position.
            screenPosition.y = Screen.height - (screenPosition.y + 1) // inverts y
            GUI.HorizontalScrollbar(Rect(screenPosition.x - 50, screenPosition.y - 12, 100, 24), 0, unitController.health.health, 0, 100)

    def OnMouseEnter():
        #Debug.Log(unitController.isEnemy)
        if unitController.isEnemy:
            Cursor.SetCursor(cursorAttack, hotSpot, cursorMode)
        #else:
            #Cursor.SetCursor(null, hotSpot, cursorMode)

    def OnMouseExit():
        Cursor.SetCursor(null, Vector2.zero, cursorMode)