import UnityEngine

/*
* Adds some debug options. Reallllyyy slow..
*/

class UIDebug(MonoBehaviour): 
    public showNames as bool = true
    private objects as List[of GameObject] = List[of GameObject]()

    def OnGUI():
        if showNames:
            // Show gamobjects name in a label
            #objects as (GameObject) = FindObjectsOfType(typeof(GameObject)) as (GameObject)
            objects as (GameObject) = GameObject.FindGameObjectsWithTag("Ship") as (GameObject)
            
            #Debug.Log("GameObjects count: " + objects.Length)

            for obj as GameObject in objects:
                Debug.Log(obj.collider.bounds.size)
                screenPosition as Vector3 = Camera.main.WorldToScreenPoint(obj.transform.position) // gets screen position.
                screenPosition.y = Screen.height - (screenPosition.y + 1) // inverts y
                #screenPosition as Vector3 = obj.transform.position


                GUI.Label(Rect(screenPosition.x - 50, screenPosition.y - 12, 100, 24), obj.name)
