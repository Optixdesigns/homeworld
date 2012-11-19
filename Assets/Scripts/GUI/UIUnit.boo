import UnityEngine

// UI For spaceobjects
[AddComponentMenu("Neworld/Unit UI")]
class UIUnit(MonoBehaviour):
    public unit as GameObject
    public unitController as Ship

    /// MAKE THIS SEPERATE CURSOR CLASS
    public cursor as Texture2D
    public cursorAttackTexture as Texture2D
    public cursorMode as CursorMode = CursorMode.Auto
    public hotSpot as Vector2

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
            DrawHealthBar()

    def DrawHealthBar():
        screenPosition as Vector3 = Camera.main.WorldToScreenPoint(unit.transform.position) // gets screen position.
        screenPosition.y = Screen.height - (screenPosition.y + 1) // inverts y
        GUI.HorizontalScrollbar(Rect(screenPosition.x - 50, screenPosition.y - 12, 100, 24), 0, unitController.health.health, 0, 100)

    def OnMouseEnter():
        #Debug.Log(unitController.isEnemy)
        if unitController.isEnemy:
            uiMain = GameObject.Find("GameManager").GetComponent(UIMain)
            #cursorData as CursorData = uiMain
            #Debug.Log(Vector2(cursorAttackTexture.width / 2, cursorAttackTexture.height / 2))
            #hotspot = Vector2(cursorAttackTexture.width / 2, cursorAttackTexture.height / 2)
            #Debug.Log(hotspot)
            Cursor.SetCursor(cursorAttackTexture, hotSpot, cursorMode)
        #else:
            #Cursor.SetCursor(null, hotSpot, cursorMode)

    def OnMouseExit():
        Cursor.SetCursor(null, Vector2.zero, cursorMode)