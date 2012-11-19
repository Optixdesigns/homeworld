import UnityEngine

/*
* Holds the main game UI
*/

class UIMain (MonoBehaviour): 
    public cursor as Texture2D
    public cursorAttack as Texture2D
    public cursorMode as CursorMode = CursorMode.Auto
    public hotSpot as Vector2 = Vector2.zero