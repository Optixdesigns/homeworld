import UnityEngine

class playerConfig:
    pass


[System.Serializable]
class PlayerController(MonoBehaviour):
    public playerName as string
    public color as Color
    public CPU as bool // Player can be a bot 

    def Start ():
        pass
    
    def Update ():
        pass

    def SetPlayerName(v as string):
        playerName = v

    def SetColor(v as Color):
        color = v

    def IsValid():
        // Check if this profile is valid
        if playerName:
            return true

        return false