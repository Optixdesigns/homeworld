import UnityEngine

class UI (MonoBehaviour): 
    public currentText as string = ""

    public textArray as (string) = array(string, 0)

    public show as bool = false
    public guiStyle as GUIStyle = GUIStyle()

    def Start ():
        pass

    def Update ():

        if Time.frameCount >= 100 and Time.frameCount <= 200:
            show = true
            currentText = "The year is 2015."
        elif Time.frameCount >= 200 and Time.frameCount <= 400:
            show = true
            currentText = "Earths resources has been depleted. Bilions op people died in the struggle for survival."
        elif Time.frameCount >= 400 and Time.frameCount <= 600:
            show = true
            currentText = "In a desperate attempt to save mankind a fleet has been send out to inner space."
        elif Time.frameCount >= 600 and Time.frameCount <= 800:
            show = true
            currentText = "Looking for a new home......"

    def OnGUI():
        if show:
            GUI.TextField(Rect(Screen.width / 2 - 100, Screen.height / 2 - 100, 200, 20), currentText, guiStyle)


